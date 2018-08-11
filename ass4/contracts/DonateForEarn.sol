pragma solidity ^0.4.18;

contract DonateForEarn {
    

    uint minDonation; // minutes
    address owner;
    address platform;
    address[] donaters = new address[](0);
    uint[] donchart = new uint[](0);

    event MinDonate(uint newValue);
    event Donation(address from, uint value);
    event Reward(address to, uint reward);

    function DonateForEarn(address plat) public {
        minDonation = 450;
        MinDonate(minDonation);
        owner = msg.sender;
        platform = plat;
    }

    

    function ownerAddress() public view returns (address) {
        return owner;
    }
    function platformAddress() public view returns (address) {
        return platform;
    }
    function setMinDonation(uint donation) public {
        if (msg.sender == owner && donation >= 1440) {
            minDonation = donation;
            MinDonate(minDonation);
        }
    }

    function donate() public payable {
        uint amount = msg.value;
        Donation(msg.sender, amount);
        require(amount > minDonation);
        require(msg.sender != owner);
        
        
        // totalDonation += amount;
        
        amount /= 2;
        
        owner.transfer(amount);
        
        if(donaters.length > 0){
            for(uint i = donaters.length - 1; i >= 0 && i < donaters.length; i--){
                address receiver = donaters[i];
                uint historyDon = donchart[i];
                uint reward = amount * historyDon /(amount + historyDon);
                receiver.transfer(reward);
                Reward(receiver, reward);
                amount = amount - reward;
            }
        }
        platform.transfer(amount);
        donaters.push(msg.sender);
        donchart.push(amount * 2);
    }
}