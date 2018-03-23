pragma solidity ^0.4.13;

contract EcommerceStore {
    enum ProductStatus {Open, Sold, Unsold}
    enum ProductCondition {New, Used}

    // 给加入到商店的每个商品赋予一个 id
    uint public productIndex;

    // 任何人都可以免费列出商店里的产品。
    // 跟踪谁插入了商品。键为商家的账户地址，值为 productIndex 到 Product 结果的 mapping.
    mapping(address => mapping(uint => Product)) stores;

    // 用于跟踪哪些商品在哪个商店
    mapping(uint => address) productIdInStore;

    struct Product {
        uint id;
        string name;
        string category;
        string imageLink;
        string descLink;
        uint auctionStartTime;
        uint auctionEndTime;
        uint startPrice;
        address highestBidder;
        uint highestBid;
        uint secondHighestBid;
        uint totalBids;
        ProductStatus status;
        ProductCondition condition;
    }

    function EcommerceStore() public {
        productIndex = 0;
    }

    function addProductToStore(string _name, string _category, string _imageLink, string _descLink, uint _auctionStartTime,
        uint _auctionEndTime, uint _startPrice, uint _productCondition) public {
        require (_auctionStartTime < _auctionEndTime);
        productIndex += 1;
        Product memory product = Product(productIndex, _name, _category, _imageLink, _descLink, _auctionStartTime, _auctionEndTime,
            _startPrice, 0, 0, 0, 0, ProductStatus.Open, ProductCondition(_productCondition));
        stores[msg.sender][productIndex] = product;
        productIdInStore[productIndex] = msg.sender;
    }

    function getProduct(uint _productId) view public returns (uint, string, string, string, string, uint, uint, uint, ProductStatus, ProductCondition) {
        Product memory product = stores[productIdInStore[_productId]][_productId];
        return (product.id, product.name, product.category, product.imageLink, product.descLink, product.auctionStartTime,
        product.auctionEndTime, product.startPrice, product.status, product.condition);
    }
}
