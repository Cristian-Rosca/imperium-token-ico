// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// ----------------------------------------------------------------------------
// EIP-20: ERC-20 Token Standard
// https://eips.ethereum.org/EIPS/eip-20
// -----------------------------------------
 
interface ERC20Interface {
    function totalSupply() external view returns (uint);
    function balanceOf(address tokenOwner) external view returns (uint balance);
    function transfer(address to, uint tokens) external returns (bool success);
    
    function allowance(address tokenOwner, address spender) external view returns (uint remaining);
    function approve(address spender, uint tokens) external returns (bool success);
    function transferFrom(address from, address to, uint tokens) external returns (bool success);
    
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
}
 
 
contract Imperium is ERC20Interface{
    string public name = "Imperium";
    string public symbol = "IMP";
    uint public decimals = 0;
    uint public override totalSupply;

    address public founder;
    mapping(address => uint) public balances;

    mapping(address => mapping(address => uint)) allowed;


    constructor(){
        totalSupply = 1000000;
        founder = msg.sender;
        balances[founder] = 1000000;
    }

    function balanceOf(address tokenOwner) public view override returns (uint balance){
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public override returns(bool success){
        require(balances[msg.sender] >= tokens);

        balances[to] += tokens;
        balances[msg.sender] -= tokens;
        emit Transfer(msg.sender, to, tokens);

        return true;
    }

    function allowance(address tokenOwner, address spender) view public override returns(uint){
        return allowed[tokenOwner][spender];
    }

    function approve(address spender, uint tokens) public override returns (bool success){
        require(balances[msg.sender] >= tokens);
        require(tokens > 0);

        allowed[msg.sender][spender] = tokens;

        emit Approval(msg.sender, spender, tokens);
        return true;

        // can also implement increaseAllowance and decreaseAllowance functions
    }

    function transferFrom(address from, address to, uint tokens) external override returns (bool success){
        require(allowed[from][msg.sender] >= tokens);
        require(balances[from] >= tokens);
        balances[from] -= tokens;
        allowed[from][msg.sender] -= tokens;
        balances[to] += tokens;

        emit Transfer(from, to, tokens);
        return true;
    }

}

 contract ImperiumICO is Imperium {
        address public admin;
        address payable public deposit;
        uint tokenPrice = 0.001 ether; // 1ETH = 1000IMP
        uint public hardCap = 300 ether;
        uint public raisedAmount;
        uint public saleStart = block.timestamp; // start at deployment
        uint public saleEnd = block.timestamp + 604800; // ICO ends in one week
        uint public tokenTradeStart = saleEnd + 604800; // Transferrable in a week after ICO ends
        uint public maxInvestment = 5 ether;
        uint public minInvestment = 0.1 ether;

        enum State {beforeStart, running, afterEnd, halted}
        State public icoState; 

        constructor(address payable _deposit){
            deposit = _deposit;
            admin = msg.sender;
            icoState = State.beforeStart;
        } 
    }