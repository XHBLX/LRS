pragma solidity ^0.4.25;
contract THQBY 
{
    
   
    
    
    
}










contract IPlayer 
	{
		function  GetVotingWeightAsPercent() public returns(uint);
		function  GetRole() public returns(string memory);
		function  GetId() public returns(uint);

		function  SetId(uint id) public ;
		function  GetIsAlive() public returns(bool);
		function  KillMe() public ;
		//function  Speak(string message) public ;
		//bool TryVote(uint playerID) public ;
		
	}



	contract IParticipatable 
	{
		function  GetParticipants() public returns(IPlayer[] memory);
		function  EnableParticipant(IPlayer player)  public ;
		function  DisableParticipant(IPlayer player) public ;
		function  DisableAllParticipants() public ;
		function  EnableAllParticipants() public ;
		
		function  IInitializable(IPlayer[] memory players) public ;
		

		function  IsRegisteredParticipant(IPlayer player) public  returns(bool);
		function  CanParticipate(IPlayer player) public  returns(bool);
		function  ParticipatablePlayersCount()  public returns(uint);

	}


contract IClock
	{
		function  GetNth_day() public returns(uint);
		function  DayPlusPlus() public ;
	function  GetRealTimeInSeconds() public returns(uint);
	}



contract IInitializable
{
    function Initialize() public;
}


contract IInitializableIPlayerArr
{
    function Initialize(IPlayer[] memory) public;
}



contract ChatMessage
	{
		 uint public  timestamp;
		 int public  byWho;
		 string public  message;
		 
		 
		 
		 constructor  (uint ts, int bw,  string memory msg ) public
		 {
		     timestamp=ts;
		     byWho=bw;
		     message=msg;
		 }
		 
	
		 
	}
	
	
	
	contract ITimeLimitable is IClock
	{

		function  IsOverTime() public returns(bool);
		function  SetTimeLimit(uint secondss) public ;
		function  IncrementTimeLimit(int secondss) public ;
		function  SetTimerOn() public ;

	}
	
		contract ITimeLimitForwardable is ITimeLimitable
	{
		



		function  TryMoveForward(IPlayer player) public returns(bool);
	}
	
	


	contract IVoteHistory
	{
		function WhoDidThePlayerVote(IPlayer player) public  returns(IPlayer);
	}


contract IBallot is IVoteHistory, IParticipatable
	{
		function DidVote(IPlayer player) public  returns(bool);
		function TryVote(IPlayer byWho, IPlayer toWho) public returns(bool);
		
		function GetWinners() public returns(IPlayer[] memory);

		function IsSoloWinder() public returns(bool);
		function IsZeroWinders() public returns(bool);
		function IsEveryVotableOnesVoted() public returns(bool);

	}


contract IChatable
	{
		function  TryChat(IPlayer player, string memory message) public returns(bool);
	}

contract IChatLog is  IParticipatable, IChatable
	{
		function GetAllMessages() public returns(ChatMessage[] memory);
		function  GetNewestMessage() public returns(ChatMessage );



		function  PrintSystemMessage(string memory message ) public ;
	}

	contract IChatter is IChatLog, ITimeLimitable, IInitializableIPlayerArr
	{



	}


contract ISequentialChatter is IChatter, ITimeLimitForwardable
	{

		function  GetSpeakingPlayer() public returns(IPlayer);
		function  HaveEveryoneSpoke() public returns(bool);
	}
	
	
	contract IPlayerFactory 
	{
	    
	    function Create(string memory str) public returns(IPlayer);
	}
	
	
	contract IPlayerManager is IInitializableIPlayerArr
	{
		function  GetPlayer(uint id) public returns(IPlayer);


		function  GetAllPlayers() public returns(IPlayer[] memory);
		function  GetAllLivingPlayers() public returns(IPlayer[] memory);
		
	



		function  GetDeadPlayers() public returns(IPlayer[] memory);
	}
	


contract IRoleBidder is IInitializable
	{


		function Bid(uint playerID, string memory role, uint bidAmount) public ;
		function  HasEveryoneBid() public returns(bool);
		function  SetPlayersCount(uint playersCount) public ;


		function CreateRoles() public returns(IPlayer[] memory);
		function  GetIsActive() public returns(bool);
	}
	
	
	


	
	
	
	contract ISceneManager is ITimeLimitForwardable, IInitializable
	{
		

		function  GetCurrentScene() public returns(IScene);

	}

	contract ISceneManagerFriendToScene is ISceneManager
	{

		function  MoveForwardToNewScene(IScene newScene) public ;

	}
	
	contract IScene is ITimeLimitable, ITimeLimitForwardable
	{
	    function Initialize(ISceneManagerFriendToScene  sceneMng, IPlayer[] memory players) public ;
	    
		function  GetSceneName() public returns(string memory);//return this.GetType().ToString();

		function  Ballot() public returns(IBallot);
		function  Chatter() public returns(IChatter);

		function  Refresh() public ;





	}
	
	contract IPrivateScene is IScene
	{
		function  ZeroVotingResultHandler() public ;
		function  OneVotingResultHandler(IPlayer result) public ;
		function  MoreVotingResultHandler(IPlayer[] memory result) public ;

		function  DoesPlayerHavePrivilageToMoveForward(IPlayer player) public returns(bool);

	}
	
	contract ITHQBYPlayerInterface
    {
        //starting game
        function Bid(string memory role, uint bidAmount) public ;

        //accessing 
        function  getID(uint id) public returns(uint);
        function  getRole(string memory role) public returns(string memory);
        function  getChatLog(ChatMessage[] memory msgs) public returns(IChatLog);

        //communicating
        function  TryChat(string memory message) public returns(bool);

        //action method
        function  TryVote(uint playerID) public returns(bool);

    }
    
    
    
    
    contract ITHQBY_PlayerManager is IPlayerManager
	{
		function  GetLivingPolicePlayers() public  returns(IPlayer[] memory);
		function  GetLivingCitizenPlayers() public returns(IPlayer[] memory);
		function  GetLivingKillerPlayers() public returns(IPlayer[] memory);
	}
	
	
	contract ITHQBY_Settings
	{


		function  DAY() public  returns(string memory);

		function  DAY_PK() public  returns(string memory);

		function  NIGHT_KILLER() public  returns(string memory);

		function  NIGHT_POLICE() public  returns(string memory);


		function  POLICE() public  returns(string memory);
		function  CITIZEN() public  returns(string memory);
		function  KILLER() public  returns(string memory);

	}
	
	
	
	
