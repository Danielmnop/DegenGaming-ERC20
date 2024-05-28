# Smart Contract
This Solidity program is a "In-game store redeeming using ERC20 token" smart contract. This program inherits from OpenZepelin ERC20 contract. This program has its main function called mint, burn, redeem, balance, and transfer.

## Description
This program is a simple contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain.

## Getting Started  
### How to run this program?
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., degenGaming.sol). Copy and paste the following code into the file:

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DegenGaming is ERC20 {
    address public owner;

    struct Item {
        string name;
        uint256 price;
    }

    mapping(uint256 => Item) public store;
    mapping(address => mapping(uint256 => bool)) public itemsOwned;

    event ItemRedeemed(address indexed player, uint256 itemId);

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        owner = msg.sender;
        
        store[1] = Item("Sword", 100);
        store[2] = Item("Shield", 150);
        store[3] = Item("Potion", 50);
        store[4] = Item("Helmet", 200);
        store[5] = Item("Armor", 250);
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

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "ERC20: transfer to the zero address");
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function redeem(uint256 itemId) external {
        require(store[itemId].price > 0, "Invalid item ID");
        require(!itemsOwned[msg.sender][itemId], "You have already redeemed this item");
        require(balanceOf(msg.sender) >= store[itemId].price, "Insufficient balance to redeem this item");
        _burn(msg.sender, store[itemId].price);
        itemsOwned[msg.sender][itemId] = true;
        emit ItemRedeemed(msg.sender, itemId);
    }
}
```



To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.0" (or another compatible version), and then click on the "Compile degenGaming.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "degenGaming" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the mint, burn, approve, transfer, transferFrom, totalSupply, name, symbol, redeem, itemsOwned, owner, store, decimal, allowance, and balanceOf functions.


## Author
Daniel Burgos


## License
This project is licensed under the MIT License - see the LICENSE.md file for details


