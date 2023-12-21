// SPDX-License-Identifier: MIT

pragma solidity > 0.8.16;


contract ERC20Token {

    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public totalSupply;


    mapping(address=>uint256) public balanceOf;


    mapping(address=> mapping(address => uint256)) public allowance;

    event Transfer(address indexed from,address indexed to,uint256 value);
    event Approve(address indexed owner,address indexed spender,uint256 value);



    constructor(string memory _name,string memory _symbol,uint256 _decimals,uint256 _totalSupply) {
        
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        balanceOf[msg.sender] = totalSupply;
    }


    function transfer(address _to,uint256 _value) external returns(bool){

        require(balanceOf[msg.sender] >= _value);

        _transfer(msg.sender,_to,_value);
        return true;
    }

    function _transfer(address _from ,address _to,uint256 _value) internal {
        
        require(_to != address(0),"transfer to address error");
        balanceOf[_from] = balanceOf[_from] - (_value);
        balanceOf[_to] = balanceOf[_to] + (_value);

        emit Transfer(_from,_to,_value);

    }


    function approve(address _spender,uint256 _value) external returns(bool) {
        
        require(_spender != address(0),"spender address error");


        allowance[msg.sender][_spender] = _value;
        
        emit Approve(msg.sender,_spender,_value);

        return true;


    }



    function transferFrom(address _from,address _to,uint256 _value) external returns (bool){
        
        require(_value <= balanceOf[_from],"value greater than from");
        require(_value <= allowance[_from][msg.sender],"value greater than from allowance");

        allowance[_from][msg.sender] = allowance[_from][msg.sender] - (_value);
        _transfer(_from,_to,_value);

        return true;
    }

}