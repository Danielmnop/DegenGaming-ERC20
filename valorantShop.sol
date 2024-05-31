// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract valorantShop is ERC20 {
    address private Agent;
    uint256 private nextItemId;

   enum ItemType { Vandal, Operator, HalfShield, FullShield, Ghost, Spectre }
    mapping(ItemType => uint256) public itemPrices;
    mapping(address => mapping(ItemType => bool)) public itemsOwned;
    mapping(ItemType => string) public ItemTypeNames;

    event ItemRedeemed(address indexed player, string itemName);

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        Agent = msg.sender;
        nextItemId = 1;

        itemPrices[ItemType.Vandal] = 2900;
        itemPrices[ItemType.Operator] = 4700;
        itemPrices[ItemType.HalfShield] = 450;
        itemPrices[ItemType.FullShield] = 900;
        itemPrices[ItemType.Ghost] = 800;
        itemPrices[ItemType.Spectre] = 1950;

        ItemTypeNames[ItemType.Vandal] = "Vandal";
        ItemTypeNames[ItemType.Operator] = "Operator";
        ItemTypeNames[ItemType.HalfShield] = "Half Shield";
        ItemTypeNames[ItemType.FullShield] = "Full Shield";
        ItemTypeNames[ItemType.Ghost] = "Ghost";
        ItemTypeNames[ItemType.Spectre] = "Spectre";
    }

    modifier Player() {
        require(msg.sender == Agent, "Only the owner can call this function");
        _;
    }

    function mint(address account, uint256 amount) external Player {
        _mint(account, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "ERC20: transfer to the zero address");
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function transferItem(ItemType itemType, address to) external {
    require(itemsOwned[msg.sender][itemType], "You do not own this item");
    require(to!= address(0), "Invalid recipient address");

    itemsOwned[msg.sender][itemType] = false;
    itemsOwned[to][itemType] = true;

    emit ItemTransferred(msg.sender, to, itemType);
}

    event ItemTransferred(address indexed from, address indexed to, ItemType itemType);

    function redeem(ItemType itemType) external {
        require(itemPrices[itemType] > 0, "Invalid item type");
        require(!itemsOwned[msg.sender][itemType], "You have already redeemed this item");
        require(balanceOf(msg.sender) >= itemPrices[itemType], "Insufficient balance to redeem this item");
        _burn(msg.sender, itemPrices[itemType]);
        itemsOwned[msg.sender][itemType] = true;
        string memory itemName = ItemTypeNames[itemType];
        emit ItemRedeemed(msg.sender, itemName);
    }
}
