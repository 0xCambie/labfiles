//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"󰋜 HOME:", "homestatus", 	0,		11},
	{"󰩠 LAN:", "lanstatus", 	0,		11},
	{"󰱓 INET:", "connectionstatus", 	0,		11},
  //{" Docker:", "dockerstatus", 	0,    11},
	//{"󰆧 VPN:", "vpnstatus", 	0,		11},
	//{"󰓾 Target:", "targetstatus", 	0,		10},
	{" ", "datestatus", 	60,		11},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
