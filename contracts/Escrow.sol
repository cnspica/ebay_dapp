pragma solidity ^0.4.18;

contract Escrow {
    uint public productId; // 产品id
    address public buyer; //买家
    address public seller; //卖家
    address public arbiter;  //仲裁
    uint public amount; //存储钱
    bool public fundsDisbursed; //钱是否已经分发出去
    mapping(address => bool) releaseAmount; // 释放金额给卖家
    uint public releaseCount;
    mapping(address => bool) refundAmount; // 退款金额给买家
    uint public refundCount;

    event CreateEscrow(uint _productId, address _buyer, address _seller, address _arbiter);
    event UnlockAmount(uint _productId, string _operation, address _operator);
    event DisburseAmount(uint _productId, uint _amount, address _beneficiary);

    function Escrow(uint _productId, address _buyer, address _seller, address _arbiter) payable public {
        productId = _productId;
        buyer = _buyer;
        seller = _seller;
        arbiter = _arbiter;
        amount = msg.value;
        fundsDisbursed = false;
        CreateEscrow(_productId, _buyer, _seller, _arbiter);
    }

    function escrowInfo() view public returns (address, address, address, bool, uint, uint) {
        return (buyer, seller, arbiter, fundsDisbursed, releaseCount, refundCount);
    }

    function releaseAmountToSeller(address caller) public {
        require(!fundsDisbursed);
        if ((caller == buyer || caller == seller || caller == arbiter) && releaseAmount[caller] != true) {
            releaseAmount[caller] = true;
            releaseCount += 1;
            UnlockAmount(productId, "release", caller);
        }

        if (releaseCount == 2) {
            seller.transfer(amount);
            fundsDisbursed = true;
            DisburseAmount(productId, amount, seller);
        }
    }

    function refundAmountToBuyer(address caller) public {
        require(!fundsDisbursed);
        if ((caller == buyer || caller == seller || caller == arbiter) && refundAmount[caller] != true) {
            refundAmount[caller] = true;
            refundCount += 1;
            UnlockAmount(productId, "refund", caller);
        }

        if (refundCount == 2) {
            buyer.transfer(amount);
            fundsDisbursed = true;
            DisburseAmount(productId, amount, buyer);
        }
    }
}
