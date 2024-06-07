# Smart Contract
This Solidity program is a "In-game store redeeming using ERC20 token" smart contract. This program inherits from OpenZepelin ERC20 contract. This program has its main function called mint, burn, redeem, balance, and transfer.

## Description
This program is a simple contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain.

## Getting Started  
### How to run this program?
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., DegenGiftCards.sol). Copy and paste the following code into the file:

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DegenGiftCards is ERC20 {
    address public owner;
    uint256 public constant GIFT_CARD_BASE_PRICE = 1000; 

    enum GiftCardType { TenDollars, TwentyDollars, FiftyDollars, HundredDollars, 
    TwoHundredDollars, ThreeHundredDollars, FourHundredDollars, FiveHundredDollars }

    struct GiftCardInfo {
        uint256 price;
        string description;
    }

    mapping(GiftCardType => GiftCardInfo) public giftCardPrices;
    mapping(address => mapping(GiftCardType => bool)) public giftCardsOwned;

    event GiftCardRedeemed(address indexed player, GiftCardType giftCardType);

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        owner = msg.sender;

        for (uint8 i = 0; i < 8; i++) {
            GiftCardType cardType = GiftCardType(i);
            uint256 price = (i + 1) * GIFT_CARD_BASE_PRICE;
            string memory description = getGiftCardDescription(cardType);
            giftCardPrices[cardType] = GiftCardInfo(price, description);
        }
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }

    function redeemGiftCard(GiftCardType giftCardType) external {
        require(giftCardType >= GiftCardType.TenDollars && giftCardType 
        <= GiftCardType.FiveHundredDollars, "Invalid gift card type");
        uint256 price = giftCardPrices[giftCardType].price;
        require(balanceOf(msg.sender) >= price, "Insufficient balance to redeem this gift card");

        _burn(msg.sender, price);
        giftCardsOwned[msg.sender][giftCardType] = true;
        emit GiftCardRedeemed(msg.sender, giftCardType);
    }

    function transferGiftCard(GiftCardType giftCardType, address to) external {
        require(giftCardsOwned[msg.sender][giftCardType], "You do not own this gift card");
        require(to != address(0), "Invalid recipient address");

        giftCardsOwned[msg.sender][giftCardType] = false;
        giftCardsOwned[to][giftCardType] = true;

        emit Transfer(msg.sender, to, giftCardPrices[giftCardType].price); 
    }

    function getGiftCardDescription(GiftCardType cardType) internal pure returns (string memory) {
        if (cardType == GiftCardType.TenDollars) {
            return "10$ Gift card";
        } else if (cardType == GiftCardType.TwentyDollars) {
            return "20$ Gift card";
        } else if (cardType == GiftCardType.FiftyDollars) {
            return "50$ Gift card";
        } else if (cardType == GiftCardType.HundredDollars) {
            return "100$ Gift card";
        } else if (cardType == GiftCardType.TwoHundredDollars) {
            return "200$ Gift card";
        } else if (cardType == GiftCardType.ThreeHundredDollars) {
            return "300$ Gift card";
        } else if (cardType == GiftCardType.FourHundredDollars) {
            return "400$ Gift card";
        } else if (cardType == GiftCardType.FiveHundredDollars) {
            return "500$ Gift card";
        } else {
            revert("Invalid gift card type");
        }
    }

}

```



To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.0" (or another compatible version), and then click on the "Compile DegenGiftCards.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "DegenGiftCards" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the mint, burn, approve, transfer, transferFrom, totalSupply,owner, name, symbol, redeemGiftCards, transferGiftCards, GIFT_CARD_BASE_PRICE, giftCardPrices, giftCardsOwned, decimal, allowance, and balanceOf functions.


## Author
Daniel Burgos


## License
This project is licensed under the MIT License - see the LICENSE.md file for details


