// SPDX-License-Identifier: BSD-2-Clause


pragma solidity ^0.8.0;

contract RockPaperScissors {
  event GameCreated(address creator, uint gameNumber, uint bet);
  event GameStarted(address[] players, uint gameNumber);
  event GameComplete(address winner, uint gameNumber);

    struct Oyun {

        address payable __creator;
        address payable __participant;
        uint  __gameNumber;
        uint  __bet;
        bool __completed;


    }
        mapping(address => uint) moves;
        Oyun[] public oyunlar;
        uint oyunsayisi =0;
        address[] public players;


  function createGame(address payable participant) public payable {

      require(msg.value > 0,"NO ETH SEND!");
      oyunsayisi++;
      oyunlar.push(Oyun(payable(msg.sender),participant,oyunsayisi,msg.value,false));
        emit GameCreated(msg.sender, oyunsayisi, msg.value);

    
  }
  


  function joinGame(uint gameNumber) public payable {


      if (msg.sender==oyunlar[gameNumber-1].__participant && msg.value>=oyunlar[gameNumber-1].__bet){

          oyunlar[gameNumber-1].__participant.transfer(msg.value - oyunlar[gameNumber-1].__bet); //fazlayı geri gönder

          
          players.push(oyunlar[gameNumber-1].__creator);
          players.push(oyunlar[gameNumber-1].__participant);
          


          emit GameStarted(players,gameNumber);

      } else {
          require(msg.value > oyunlar[gameNumber-1].__bet,"ISLEME GIRIS ICIN YETERLI ETH GONDERMEDINIZ");
          require(msg.sender==oyunlar[gameNumber-1].__participant,"ISLEME GIRMEYE YETKILI DEGILSINIZ");

      }
  
  }
 

  function makeMove(uint gameNumber, uint moveNumber) public { 
    
      require(oyunlar[gameNumber-1].__completed = true,"BITMIS OYUNA MUDAHALE EDEMEZSIN");
    
      if(moveNumber !=1 || moveNumber !=2 || moveNumber !=3 ) {revert("YANLIS HAMLE NUMARASI 1-2-3");}

      if (msg.sender==oyunlar[gameNumber-1].__participant) {

          moves[msg.sender]=moveNumber;


      } else if(msg.sender==oyunlar[gameNumber-1].__creator) {
          moves[msg.sender]=moveNumber;
      } else {
          revert("SEN KIMSIN YA???");
      }



        if(moves[oyunlar[gameNumber-1].__participant] == moves[oyunlar[gameNumber-1].__creator] ) {emit GameComplete(address(0),gameNumber); }
        if(moves[oyunlar[gameNumber-1].__participant]==1 && moves[oyunlar[gameNumber-1].__creator]==2 ) {emit GameComplete(oyunlar[gameNumber-1].__creator,gameNumber); oyunlar[gameNumber-1].__creator.transfer(oyunlar[gameNumber-1].__bet);}
        if(moves[oyunlar[gameNumber-1].__participant]==1 && moves[oyunlar[gameNumber-1].__creator]==3 ) {emit GameComplete(oyunlar[gameNumber-1].__participant,gameNumber); oyunlar[gameNumber-1].__participant.transfer(oyunlar[gameNumber-1].__bet);}
        if(moves[oyunlar[gameNumber-1].__participant]==2 && moves[oyunlar[gameNumber-1].__creator]==1 ) {emit GameComplete(oyunlar[gameNumber-1].__participant,gameNumber);oyunlar[gameNumber-1].__participant.transfer(oyunlar[gameNumber-1].__bet);}
        if(moves[oyunlar[gameNumber-1].__participant]==2 && moves[oyunlar[gameNumber-1].__creator]==3 ) {emit GameComplete(oyunlar[gameNumber-1].__creator,gameNumber);oyunlar[gameNumber-1].__creator.transfer(oyunlar[gameNumber-1].__bet);}
        if(moves[oyunlar[gameNumber-1].__participant]==3 && moves[oyunlar[gameNumber-1].__creator]==1 ) {emit GameComplete(oyunlar[gameNumber-1].__creator,gameNumber);oyunlar[gameNumber-1].__creator.transfer(oyunlar[gameNumber-1].__bet);}
        if(moves[oyunlar[gameNumber-1].__participant]==3 && moves[oyunlar[gameNumber-1].__creator]==2 ) {emit GameComplete(oyunlar[gameNumber-1].__participant,gameNumber);oyunlar[gameNumber-1].__participant.transfer(oyunlar[gameNumber-1].__bet);}

    oyunlar[gameNumber-1].__completed = true;
    
    
   
  }
}