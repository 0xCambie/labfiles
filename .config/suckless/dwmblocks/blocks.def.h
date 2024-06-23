//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"󰩠 LAN:", "lanstatus",           	0,		11},
	{"󰱓 HOME:", "homestatus", 	        0,		11},
	{"󰛵 INET:", "connectionstatus",   	0,		11},
	{"󰆧 VPN:", "vpnstatus",           	0,		11},
	{"󰓾 Target:", "targetstatus", 	    0,	10},
  //{"", "date '+%b %d (%a) %I:%M%p'", 30,   0}
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
