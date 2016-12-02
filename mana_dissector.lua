--inicijalizirali novi protokol sa željenim imenom
mana_protocol = Proto("Mana",  "The MANA WORLD Protocol")

--varijable koje su važne za protokol – potrebno je definirati kojem protokolu pripadaju, ime i tip podatka
msg_type =ProtoField.uint16("Mana.MessageType","Tip paketa",base.HEX)
msgleni = ProtoField.uint8("Mana.Length","Dužina poruke",base.DEC)

--Nakon toga smo varijable pridužili novom protokolu
data = ProtoField.string("Mana.Data","Podatci","Text")
message = ProtoField.string("Mana.Message","Data","Text")
mana_protocol.fields = {msg_type,msglen,data,message}

--varijabla za pocetak citanja cijelog segmenta
pocetak=0

--definiranje funkciju za disekciju s odgovarajućim parametrima.			
function mana_protocol.dissector(buffer, pinfo, tree)
	
		--inicijalizacija mana_protocol
		pinfo.cols.protocol = mana_protocol.name;
		
		--dodaj subtree
		subtree = tree:add(mana_protocol,buffer())
		
		
		--ucitaj prva dva bajta
		mtype = buffer(pocetak,2):le_uint()
		mtype_str = "hardcoded"
		
		--tip poruke na temelju identifikatora mtype
		--tip paketa se sprema u varijablu mtype_str
		if mtype == 	0x0061	 then mtype_str = "	CMSG_CHAR_PASSWORD_CHANGE	 "  end
		if mtype == 	0x0062	 then mtype_str = "	SMSG_CHAR_PASSWORD_RESPONSE	 " end
		if mtype == 	0x0063	 then mtype_str = "	SMSG_UPDATE_HOST	 " end
		if mtype == 	0x0064	 then mtype_str = "	(hard-coded)	 " end
		if mtype == 	0x0065	 then mtype_str = "	CMSG_CHAR_SERVER_CONNECT	 " end
		if mtype == 	0x0066	 then mtype_str = "	CMSG_CHAR_SELECT	 " end
		if mtype == 	0x0067	 then mtype_str = "	CMSG_CHAR_CREATE	 " end
		if mtype == 	0x0068	 then mtype_str = "	CMSG_CHAR_DELETE	 " end
		if mtype == 	0x0069	 then mtype_str = "	SMSG_LOGIN_DATA	 " end
		if mtype == 	0x006A	 then mtype_str = "	SMSG_LOGIN_ERROR	 " end
		if mtype == 	0x006B	 then mtype_str = "	SMSG_CHAR_LOGIN	 " end
		if mtype == 	0x006C	 then mtype_str = "	SMSG_CHAR_LOGIN_ERROR	 " end
		if mtype == 	0x006D	 then mtype_str = "	SMSG_CHAR_CREATE_SUCCEEDED	 " end
		if mtype == 	0x006E	 then mtype_str = "	SMSG_CHAR_CREATE_FAILED	 " end
		if mtype == 	0x006F	 then mtype_str = "	SMSG_CHAR_DELETE_SUCCEEDED	 " end
		if mtype == 	0x0070	 then mtype_str = "	SMSG_CHAR_DELETE_FAILED	 " end
		if mtype == 	0x0071	 then mtype_str = "	SMSG_CHAR_MAP_INFO	 " end
		if mtype == 	0x0072	 then mtype_str = "	CMSG_MAP_SERVER_CONNECT	 " end
		if mtype == 	0x0073	 then mtype_str = "	SMSG_MAP_LOGIN_SUCCESS	 " end
		if mtype == 	0x0078	 then mtype_str = "	SMSG_BEING_VISIBLE	 " end
		if mtype == 	0x007B	 then mtype_str = "	SMSG_BEING_MOVE	 " end
		if mtype == 	0x007C	 then mtype_str = "	SMSG_BEING_SPAWN	 " end
		if mtype == 	0x007D	 then mtype_str = "	CMSG_MAP_LOADED	 " end
		if mtype == 	0x007E	 then mtype_str = "	CMSG_CLIENT_PING	 " end
		if mtype == 	0x007F	 then mtype_str = "	SMSG_SERVER_PING	 " end
		if mtype == 	0x0080	 then mtype_str = "	SMSG_BEING_REMOVE	 " end
		if mtype == 	0x0081	 then mtype_str = "	SMSG_CONNECTION_PROBLEM	 " end
		if mtype == 	0x0085	 then mtype_str = "	CMSG_PLAYER_CHANGE_DEST	 " end
		if mtype == 	0x0086	 then mtype_str = "	SMSG_BEING_MOVE2	 " end
		if mtype == 	0x0087	 then mtype_str = "	SMSG_WALK_RESPONSE	 " end
		if mtype == 	0x0088	 then mtype_str = "	SMSG_PLAYER_STOP	 " end
		if mtype == 	0x0089	 then mtype_str = "	CMSG_PLAYER_CHANGE_ACT	 " end
		if mtype == 	0x0089	 then mtype_str = "	CMSG_PLAYER_ATTACK	 " end
		if mtype == 	0x008A	 then mtype_str = "	SMSG_BEING_ACTION	 " end
		if mtype == 	0x008C	 then mtype_str = "	CMSG_CHAT_MESSAGE	 " end
		if mtype == 	0x008D	 then mtype_str = "	SMSG_BEING_CHAT	 " end
		if mtype == 	0x008E	 then mtype_str = "	SMSG_PLAYER_CHAT	 " end
		if mtype == 	0x0090	 then mtype_str = "	CMSG_NPC_TALK	 " end
		if mtype == 	0x0091	 then mtype_str = "	SMSG_PLAYER_WARP	 " end
		if mtype == 	0x0092	 then mtype_str = "	SMSG_CHANGE_MAP_SERVER	 " end
		if mtype == 	0x0094	 then mtype_str = "	(hard-coded)	 " end
		if mtype == 	0x0095	 then mtype_str = "	SMSG_BEING_NAME_RESPONSE	 " end
		if mtype == 	0x0096	 then mtype_str = "	CMSG_CHAT_WHISPER	 " end
		if mtype == 	0x0097	 then mtype_str = "	SMSG_WHISPER	 " end
		if mtype == 	0x0098	 then mtype_str = "	SMSG_WHISPER_RESPONSE	 " end
		if mtype == 	0x0099	 then mtype_str = "	CMSG_ADMIN_ANNOUNCE	 " end
		if mtype == 	0x0099	 then mtype_str = "	CMSG_CHAT_ANNOUNCE	 " end
		if mtype == 	0x009A	 then mtype_str = "	SMSG_GM_CHAT	 " end
		if mtype == 	0x009B	 then mtype_str = "	CMSG_PLAYER_CHANGE_DIR	 " end
		if mtype == 	0x009C	 then mtype_str = "	SMSG_BEING_CHANGE_DIRECTION	 " end
		if mtype == 	0x009D	 then mtype_str = "	SMSG_ITEM_VISIBLE	 " end
		if mtype == 	0x009E	 then mtype_str = "	SMSG_ITEM_DROPPED	 " end
		if mtype == 	0x009F	 then mtype_str = "	CMSG_ITEM_PICKUP	 " end
		if mtype == 	0x00A0	 then mtype_str = "	SMSG_PLAYER_INVENTORY_ADD	 " end
		if mtype == 	0x00A1	 then mtype_str = "	SMSG_ITEM_REMOVE	 " end
		if mtype == 	0x00A2	 then mtype_str = "	CMSG_PLAYER_INVENTORY_DROP	 " end
		if mtype == 	0x00A4	 then mtype_str = "	SMSG_PLAYER_EQUIPMENT	 " end
		if mtype == 	0x00A6	 then mtype_str = "	SMSG_PLAYER_STORAGE_EQUIP	 " end
		if mtype == 	0x00A7	 then mtype_str = "	CMSG_PLAYER_INVENTORY_USE	 " end
		if mtype == 	0x00A8	 then mtype_str = "	SMSG_ITEM_USE_RESPONSE	 " end
		if mtype == 	0x00A9	 then mtype_str = "	CMSG_PLAYER_EQUIP	 " end
		if mtype == 	0x00AA	 then mtype_str = "	SMSG_PLAYER_EQUIP	 " end
		if mtype == 	0x00AB	 then mtype_str = "	CMSG_PLAYER_UNEQUIP	 " end
		if mtype == 	0x00AC	 then mtype_str = "	SMSG_PLAYER_UNEQUIP	 " end
		if mtype == 	0x00AF	 then mtype_str = "	SMSG_PLAYER_INVENTORY_REMOVE	 " end
		if mtype == 	0x00B0	 then mtype_str = "	SMSG_PLAYER_STAT_UPDATE_1	 " end
		if mtype == 	0x00B1	 then mtype_str = "	SMSG_PLAYER_STAT_UPDATE_2	 " end
		if mtype == 	0x00B2	 then mtype_str = "	CMSG_PLAYER_RESTART	 " end
		if mtype == 	0x00B3	 then mtype_str = "	SMSG_CHAR_SWITCH_RESPONSE	 " end
		if mtype == 	0x00B4	 then mtype_str = "	SMSG_NPC_MESSAGE	 " end
		if mtype == 	0x00B5	 then mtype_str = "	SMSG_NPC_NEXT	 " end
		if mtype == 	0x00B6	 then mtype_str = "	SMSG_NPC_CLOSE	 " end
		if mtype == 	0x00B7	 then mtype_str = "	SMSG_NPC_CHOICE	 " end
		if mtype == 	0x00B8	 then mtype_str = "	CMSG_NPC_LIST_CHOICE	 " end
		if mtype == 	0x00B9	 then mtype_str = "	CMSG_NPC_NEXT_REQUEST	 " end
		if mtype == 	0x00BB	 then mtype_str = "	CMSG_STAT_UPDATE_REQUEST	 " end
		if mtype == 	0x00BC	 then mtype_str = "	SMSG_PLAYER_STAT_UPDATE_4	 " end
		if mtype == 	0x00BD	 then mtype_str = "	SMSG_PLAYER_STAT_UPDATE_5	 " end
		if mtype == 	0x00BE	 then mtype_str = "	SMSG_PLAYER_STAT_UPDATE_6	 " end
		if mtype == 	0x00BF	 then mtype_str = "	CMSG_PLAYER_EMOTE	 " end
		if mtype == 	0x00C0	 then mtype_str = "	SMSG_BEING_EMOTION	 " end
		if mtype == 	0x00C1	 then mtype_str = "	CMSG_WHO_REQUEST	 " end
		if mtype == 	0x00C1	 then mtype_str = "	CMSG_CHAT_WHO	 " end
		if mtype == 	0x00C2	 then mtype_str = "	SMSG_WHO_ANSWER	 " end
		if mtype == 	0x00C3	 then mtype_str = "	SMSG_BEING_CHANGE_LOOKS	 " end
		if mtype == 	0x00C4	 then mtype_str = "	SMSG_NPC_BUY_SELL_CHOICE	 " end
		if mtype == 	0x00C5	 then mtype_str = "	CMSG_NPC_BUY_SELL_REQUEST	 " end
		if mtype == 	0x00C6	 then mtype_str = "	SMSG_NPC_BUY	 " end
		if mtype == 	0x00C7	 then mtype_str = "	SMSG_NPC_SELL	 " end
		if mtype == 	0x00C8	 then mtype_str = "	CMSG_NPC_BUY_REQUEST	 " end
		if mtype == 	0x00C9	 then mtype_str = "	CMSG_NPC_SELL_REQUEST	 " end
		if mtype == 	0x00CA	 then mtype_str = "	SMSG_NPC_BUY_RESPONSE	 " end
		if mtype == 	0x00CB	 then mtype_str = "	SMSG_NPC_SELL_RESPONSE	 " end
		if mtype == 	0x00CC	 then mtype_str = "	CMSG_ADMIN_KICK	 " end
		if mtype == 	0x00CD	 then mtype_str = "	SMSG_ADMIN_KICK_ACK	 " end
		if mtype == 	0x00E4	 then mtype_str = "	CMSG_TRADE_REQUEST	 " end
		if mtype == 	0x00E5	 then mtype_str = "	SMSG_TRADE_REQUEST	 " end
		if mtype == 	0x00E6	 then mtype_str = "	CMSG_TRADE_RESPONSE	 " end
		if mtype == 	0x00E7	 then mtype_str = "	SMSG_TRADE_RESPONSE	 " end
		if mtype == 	0x00E8	 then mtype_str = "	CMSG_TRADE_ITEM_ADD_REQUEST	 " end
		if mtype == 	0x00E9	 then mtype_str = "	SMSG_TRADE_ITEM_ADD	 " end
		if mtype == 	0x00EB	 then mtype_str = "	CMSG_TRADE_ADD_COMPLETE	 " end
		if mtype == 	0x00EC	 then mtype_str = "	SMSG_TRADE_OK	 " end
		if mtype == 	0x00ED	 then mtype_str = "	CMSG_TRADE_CANCEL_REQUEST	 " end
		if mtype == 	0x00EE	 then mtype_str = "	SMSG_TRADE_CANCEL	 " end
		if mtype == 	0x00EF	 then mtype_str = "	CMSG_TRADE_OK	 " end
		if mtype == 	0x00F0	 then mtype_str = "	SMSG_TRADE_COMPLETE	 " end
		if mtype == 	0x00F2	 then mtype_str = "	SMSG_PLAYER_STORAGE_STATUS	 " end
		if mtype == 	0x00F3	 then mtype_str = "	CMSG_MOVE_TO_STORAGE	 " end
		if mtype == 	0x00F4	 then mtype_str = "	SMSG_PLAYER_STORAGE_ADD	 " end
		if mtype == 	0x00F5	 then mtype_str = "	CSMG_MOVE_FROM_STORAGE	 " end
		if mtype == 	0x00F6	 then mtype_str = "	SMSG_PLAYER_STORAGE_REMOVE	 " end
		if mtype == 	0x00F7	 then mtype_str = "	CMSG_CLOSE_STORAGE	 " end
		if mtype == 	0x00F8	 then mtype_str = "	SMSG_PLAYER_STORAGE_CLOSE	 " end
		if mtype == 	0x00F9	 then mtype_str = "	CMSG_PARTY_CREATE	 " end
		if mtype == 	0x00FA	 then mtype_str = "	SMSG_PARTY_CREATE	 " end
		if mtype == 	0x00FB	 then mtype_str = "	SMSG_PARTY_INFO	 " end
		if mtype == 	0x00FC	 then mtype_str = "	CMSG_PARTY_INVITE	 " end
		if mtype == 	0x00FD	 then mtype_str = "	SMSG_PARTY_INVITE_RESPONSE	 " end
		if mtype == 	0x00FE	 then mtype_str = "	SMSG_PARTY_INVITED	 " end
		if mtype == 	0x00FF	 then mtype_str = "	CMSG_PARTY_INVITED	 " end
		if mtype == 	0x0100	 then mtype_str = "	CMSG_PARTY_LEAVE	 " end
		if mtype == 	0x0101	 then mtype_str = "	SMSG_PARTY_SETTINGS	 " end
		if mtype == 	0x0102	 then mtype_str = "	CMSG_PARTY_SETTINGS	 " end
		if mtype == 	0x0103	 then mtype_str = "	CMSG_PARTY_KICK	 " end
		if mtype == 	0x0104	 then mtype_str = "	SMSG_PARTY_MOVE	 " end
		if mtype == 	0x0105	 then mtype_str = "	SMSG_PARTY_LEAVE	 " end
		if mtype == 	0x0106	 then mtype_str = "	SMSG_PARTY_UPDATE_HP	 " end
		if mtype == 	0x0107	 then mtype_str = "	SMSG_PARTY_UPDATE_COORDS	 " end
		if mtype == 	0x0108	 then mtype_str = "	CMSG_PARTY_MESSAGE	 " end
		if mtype == 	0x0109	 then mtype_str = "	SMSG_PARTY_MESSAGE	 " end
		if mtype == 	0x010C	 then mtype_str = "	SMSG_MVP	 " end
		if mtype == 	0x010E	 then mtype_str = "	SMSG_PLAYER_SKILL_UP	 " end
		if mtype == 	0x010E	 then mtype_str = "	SMSG_GUILD_SKILL_UP	 " end
		if mtype == 	0x010F	 then mtype_str = "	SMSG_PLAYER_SKILLS	 " end
		if mtype == 	0x0110	 then mtype_str = "	SMSG_SKILL_FAILED	 " end
		if mtype == 	0x0112	 then mtype_str = "	CMSG_SKILL_LEVELUP_REQUEST	 " end
		if mtype == 	0x0113	 then mtype_str = "	CMSG_SKILL_USE_BEING	 " end
		if mtype == 	0x0116	 then mtype_str = "	CMSG_SKILL_USE_POSITION	 " end
		if mtype == 	0x0119	 then mtype_str = "	SMSG_PLAYER_STATUS_CHANGE	 " end
		if mtype == 	0x011B	 then mtype_str = "	CMSG_SKILL_USE_MAP	 " end
		if mtype == 	0x0139	 then mtype_str = "	SMSG_PLAYER_MOVE_TO_ATTACK	 " end
		if mtype == 	0x013A	 then mtype_str = "	SMSG_PLAYER_ATTACK_RANGE	 " end
		if mtype == 	0x013B	 then mtype_str = "	SMSG_PLAYER_ARROW_MESSAGE	 " end
		if mtype == 	0x013C	 then mtype_str = "	SMSG_PLAYER_ARROW_EQUIP	 " end
		if mtype == 	0x0141	 then mtype_str = "	SMSG_PLAYER_STAT_UPDATE_3	 " end
		if mtype == 	0x0142	 then mtype_str = "	SMSG_NPC_INT_INPUT	 " end
		if mtype == 	0x0143	 then mtype_str = "	CMSG_NPC_INT_RESPONSE	 " end
		if mtype == 	0x0146	 then mtype_str = "	CMSG_NPC_CLOSE	 " end
		if mtype == 	0x0148	 then mtype_str = "	SMSG_BEING_RESURRECT	 " end
		if mtype == 	0x0149	 then mtype_str = "	CMSG_ADMIN_MUTE	 " end
		if mtype == 	0x014C	 then mtype_str = "	SMSG_GUILD_ALIANCE_INFO	 " end
		if mtype == 	0x014D	 then mtype_str = "	CMSG_GUILD_CHECK_MASTER	 " end
		if mtype == 	0x014E	 then mtype_str = "	SMSG_GUILD_MASTER_OR_MEMBER	 " end
		if mtype == 	0x014F	 then mtype_str = "	CMSG_GUILD_REQUEST_INFO	 " end
		if mtype == 	0x0151	 then mtype_str = "	CMSG_GUILD_REQUEST_EMBLEM	 " end
		if mtype == 	0x0152	 then mtype_str = "	SMSG_GUILD_EMBLEM	 " end
		if mtype == 	0x0153	 then mtype_str = "	CMSG_GUILD_CHANGE_EMBLEM	 " end
		if mtype == 	0x0154	 then mtype_str = "	SMSG_GUILD_MEMBER_LIST	 " end
		if mtype == 	0x0155	 then mtype_str = "	CMSG_GUILD_CHANGE_MEMBER_POS	 " end
		if mtype == 	0x0156	 then mtype_str = "	SMSG_GUILD_MEMBER_POS_CHANGE	 " end
		if mtype == 	0x0159	 then mtype_str = "	CMSG_GUILD_LEAVE	 " end
		if mtype == 	0x015A	 then mtype_str = "	SMSG_GUILD_LEAVE	 " end
		if mtype == 	0x015B	 then mtype_str = "	CMSG_GUILD_EXPULSION	 " end
		if mtype == 	0x015C	 then mtype_str = "	SMSG_GUILD_EXPULSION	 " end
		if mtype == 	0x015D	 then mtype_str = "	CMSG_GUILD_BREAK	 " end
		if mtype == 	0x015E	 then mtype_str = "	SMSG_GUILD_BROKEN	 " end
		if mtype == 	0x0160	 then mtype_str = "	SMSG_GUILD_POS_INFO_LIST	 " end
		if mtype == 	0x0161	 then mtype_str = "	CMSG_GUILD_CHANGE_POS_INFO	 " end
		if mtype == 	0x0162	 then mtype_str = "	SMSG_GUILD_SKILL_INFO	 " end
		if mtype == 	0x0163	 then mtype_str = "	SMSG_GUILD_EXPULSION_LIST	 " end
		if mtype == 	0x0165	 then mtype_str = "	CMSG_GUILD_CREATE	 " end
		if mtype == 	0x0166	 then mtype_str = "	SMSG_GUILD_POS_NAME_LIST	 " end
		if mtype == 	0x0167	 then mtype_str = "	SMSG_GUILD_CREATE_RESPONSE	 " end
		if mtype == 	0x0168	 then mtype_str = "	CMSG_GUILD_INVITE	 " end
		if mtype == 	0x0169	 then mtype_str = "	SMSG_GUILD_INVITE_ACK	 " end
		if mtype == 	0x016A	 then mtype_str = "	SMSG_GUILD_INVITE	 " end
		if mtype == 	0x016B	 then mtype_str = "	CMSG_GUILD_INVITE_REPLY	 " end
		if mtype == 	0x016C	 then mtype_str = "	SMSG_GUILD_POSITION_INFO	 " end
		if mtype == 	0x016D	 then mtype_str = "	SMSG_GUILD_MEMBER_LOGIN	 " end
		if mtype == 	0x016E	 then mtype_str = "	CMSG_GUILD_CHANGE_NOTICE	 " end
		if mtype == 	0x016F	 then mtype_str = "	SMSG_GUILD_NOTICE	 " end
		if mtype == 	0x0170	 then mtype_str = "	CMSG_GUILD_ALLIANCE_REQUEST	 " end
		if mtype == 	0x0171	 then mtype_str = "	SMSG_GUILD_REQ_ALLIANCE	 " end
		if mtype == 	0x0172	 then mtype_str = "	CMSG_GUILD_ALLIANCE_REPLY	 " end
		if mtype == 	0x0173	 then mtype_str = "	SMSG_GUILD_REQ_ALLIANCE_ACK	 " end
		if mtype == 	0x0174	 then mtype_str = "	SMSG_GUILD_POSITION_CHANGED	 " end
		if mtype == 	0x017E	 then mtype_str = "	CMSG_GUILD_MESSAGE	 " end
		if mtype == 	0x017F	 then mtype_str = "	SMSG_GUILD_MESSAGE	 " end
		if mtype == 	0x0180	 then mtype_str = "	CMSG_GUILD_OPPOSITION	 " end
		if mtype == 	0x0181	 then mtype_str = "	SMSG_GUILD_OPPOSITION_ACK	 " end
		if mtype == 	0x0183	 then mtype_str = "	CMSG_GUILD_ALLIANCE_DELETE	 " end
		if mtype == 	0x0184	 then mtype_str = "	SMSG_GUILD_DEL_ALLIANCE	 " end
		if mtype == 	0x018A	 then mtype_str = "	CMSG_CLIENT_QUIT	 " end
		if mtype == 	0x018B	 then mtype_str = "	SMSG_MAP_QUIT_RESPONSE	 " end
		if mtype == 	0x0190	 then mtype_str = "	CMSG_SKILL_USE_POSITION_MORE	 " end
		if mtype == 	0x0195	 then mtype_str = "	SMSG_PLAYER_GUILD_PARTY_INFO	 " end
		if mtype == 	0x0196	 then mtype_str = "	SMSG_BEING_STATUS_CHANGE	 " end
		if mtype == 	0x019B	 then mtype_str = "	SMSG_BEING_SELFEFFECT	 " end
		if mtype == 	0x019C	 then mtype_str = "	CMSG_ADMIN_LOCAL_ANNOUNCE	 " end
		if mtype == 	0x019D	 then mtype_str = "	CMSG_ADMIN_HIDE	 " end
		if mtype == 	0x01B1	 then mtype_str = "	SMSG_TRADE_ITEM_ADD_RESPONSE	 " end
		if mtype == 	0x01B6	 then mtype_str = "	SMSG_GUILD_BASIC_INFO	 " end
		if mtype == 	0x01C8	 then mtype_str = "	SMSG_PLAYER_INVENTORY_USE	 " end
		if mtype == 	0x01D4	 then mtype_str = "	SMSG_NPC_STR_INPUT	 " end
		if mtype == 	0x01D5	 then mtype_str = "	CMSG_NPC_STR_RESPONSE	 " end
		if mtype == 	0x01D7	 then mtype_str = "	SMSG_BEING_CHANGE_LOOKS2	 " end
		if mtype == 	0x01D8	 then mtype_str = "	SMSG_PLAYER_UPDATE_1	 " end
		if mtype == 	0x01D9	 then mtype_str = "	SMSG_PLAYER_UPDATE_2	 " end
		if mtype == 	0x01DA	 then mtype_str = "	SMSG_PLAYER_MOVE	 " end
		if mtype == 	0x01DE	 then mtype_str = "	SMSG_SKILL_DAMAGE	 " end
		if mtype == 	0x01EE	 then mtype_str = "	SMSG_PLAYER_INVENTORY	 " end
		if mtype == 	0x01F0	 then mtype_str = "	SMSG_PLAYER_STORAGE_ITEMS	 " end
		if mtype == 	0x020C	 then mtype_str = "	SMSG_ADMIN_IP	 " end
		if mtype == 	0x7530	 then mtype_str = "	CMSG_SERVER_VERSION_REQUEST	 " end
		if mtype == 	0x7531	 then mtype_str = "	SMSG_SERVER_VERSION_RESPONSE	 " end
		if mtype == 	0x0000	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0074	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0075	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0076	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0077	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0079	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x007A	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0082	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0083	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0084	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x008B	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0093	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00A3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00A5	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00AE	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00BA	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00CE	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00CF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00D0	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00D1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00D2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00D3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00D4	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00D5	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00D6	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00D7	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00D8	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00D9	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00DA	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00DB	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00DC	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00DD	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00DE	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00DF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00E0	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00E1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00E2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00E3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00EA	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x00F1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x010A	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x010B	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x010D	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0111	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0114	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0115	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0117	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0118	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x011A	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x011C	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x011D	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x011E	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x011F	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0120	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0121	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0122	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0123	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0124	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0125	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0126	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0127	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0128	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0129	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x012A	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x012B	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x012C	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x012D	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x012E	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x012F	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0130	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0131	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0132	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0133	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0134	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0135	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0136	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0137	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0138	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x013D	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x013E	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x013F	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0140	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0144	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0145	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0147	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x014A	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x014B	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0150	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0157	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0158	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x015F	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0164	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0175	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0176	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0177	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0178	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0179	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x017A	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x017B	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x017C	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x017D	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0182	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0185	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0187	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0188	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0189	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x018C	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x018D	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x018E	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x018F	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0191	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0192	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0193	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0194	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0197	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0198	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0199	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x019A	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x019E	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x019F	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01A0	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01A1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01A2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01A3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01A4	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01A5	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01A6	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01A7	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01A8	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01A9	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01AA	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01AB	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01AC	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01AD	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01AE	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01AF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01B0	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01B2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01B3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01B4	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01B5	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01B7	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01B8	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01B9	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01BA	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01BB	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01BC	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01BD	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01BE	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01BF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01C0	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01C1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01C2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01C3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01C4	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01C5	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01C6	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01C7	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01C9	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01CB	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01CC	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01CD	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01CE	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01CF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01D0	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01D1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01D2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01D3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01D6	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01DB	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01DC	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01DD	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01DF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01E0	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01E1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01E2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01E3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01E4	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01E5	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01E6	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01E7	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01E8	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01E9	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01EA	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01EB	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01EC	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01ED	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01EF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01F1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01F2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01F3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01F4	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01F5	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01F6	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01F7	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01F8	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01F9	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01FA	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01FB	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01FC	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01FD	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01FE	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x01FF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0200	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x0204	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x020B	 then mtype_str = "	KATEGORIJA Free Packets	 " end
		if mtype == 	0x2709	 then mtype_str = "	Reload GM Account Request	 " end
		if mtype == 	0x2711	 then mtype_str = "	Indicator of success/failure of login	 " end
		if mtype == 	0x2712	 then mtype_str = "	Request login server to authenticate an account	 " end
		if mtype == 	0x2713	 then mtype_str = "	Authentication response from login server	 " end
		if mtype == 	0x2714	 then mtype_str = "	Current User Count	 " end
		if mtype == 	0x2716	 then mtype_str = "	Request Email and Time Limit	 " end
		if mtype == 	0x2717	 then mtype_str = "	Email and Time Limit Response	 " end
		if mtype == 	0x2722	 then mtype_str = "	Account Email Change Request	 " end
		if mtype == 	0x2723	 then mtype_str = "	Sex Change Response	 " end
		if mtype == 	0x2724	 then mtype_str = "	Change Ban Status Request	 " end
		if mtype == 	0x2727	 then mtype_str = "	Sex Change Request	 " end
		if mtype == 	0x2731	 then mtype_str = "	Change Ban Status Response	 " end
		if mtype == 	0x2740	 then mtype_str = "	Password Change Request (Internal)	 " end
		if mtype == 	0x2741	 then mtype_str = "	Password Change Response (Internal)	 " end
		
		--deklarirana velicina poruke na temelju identifikatora mtype
		--velicina se sprema u varijablu msgleni
		if mtype ==	0x0061	then msgleni =	50	end
		if mtype ==	0x0062	then msgleni =	3	end
		if mtype ==	0x0063	then msgleni =	-1	end
		if mtype ==	0x0064	then msgleni =	55	end
		if mtype ==	0x0065	then msgleni =	17	end
		if mtype ==	0x0066	then msgleni =	3	end
		if mtype ==	0x0067	then msgleni =	37	end
		if mtype ==	0x0068	then msgleni =	46	end
		if mtype ==	0x0069	then msgleni =	-1	end
		if mtype ==	0x006A	then msgleni =	23	end
		if mtype ==	0x006B	then msgleni =	-1	end
		if mtype ==	0x006C	then msgleni =	3	end
		if mtype ==	0x006D	then msgleni =	108	end
		if mtype ==	0x006E	then msgleni =	3	end
		if mtype ==	0x006F	then msgleni =	2	end
		if mtype ==	0x0070	then msgleni =	3	end
		if mtype ==	0x0071	then msgleni =	28	end
		if mtype ==	0x0072	then msgleni =	19	end
		if mtype ==	0x0073	then msgleni =	11	end
		if mtype ==	0x0078	then msgleni =	54	end
		if mtype ==	0x007B	then msgleni =	60	end
		if mtype ==	0x007C	then msgleni =	41	end
		if mtype ==	0x007D	then msgleni =	2	end
		if mtype ==	0x007E	then msgleni =	6	end
		if mtype ==	0x007F	then msgleni =	6	end
		if mtype ==	0x0080	then msgleni =	7	end
		if mtype ==	0x0081	then msgleni =	3	end
		if mtype ==	0x0085	then msgleni =	5	end
		if mtype ==	0x0086	then msgleni =	16	end
		if mtype ==	0x0087	then msgleni =	12	end
		if mtype ==	0x0088	then msgleni =	10	end
		if mtype ==	0x0089	then msgleni =	7	end
		if mtype ==	0x008A	then msgleni =	29	end
		if mtype ==	0x008C	then msgleni =	-1	end
		if mtype ==	0x008D	then msgleni =	-1	end
		if mtype ==	0x008E	then msgleni =	-1	end
		if mtype ==	0x0090	then msgleni =	7	end
		if mtype ==	0x0091	then msgleni =	22	end
		if mtype ==	0x0092	then msgleni =	28	end
		if mtype ==	0x0094	then msgleni =	6	end
		if mtype ==	0x0095	then msgleni =	30	end
		if mtype ==	0x0096	then msgleni =	-1	end
		if mtype ==	0x0097	then msgleni =	-1	end
		if mtype ==	0x0098	then msgleni =	3	end
		if mtype ==	0x0099	then msgleni =	-1	end
		if mtype ==	0x009A	then msgleni =	-1	end
		if mtype ==	0x009B	then msgleni =	5	end
		if mtype ==	0x009C	then msgleni =	9	end
		if mtype ==	0x009D	then msgleni =	17	end
		if mtype ==	0x009E	then msgleni =	17	end
		if mtype ==	0x009F	then msgleni =	6	end
		if mtype ==	0x00A0	then msgleni =	23	end
		if mtype ==	0x00A1	then msgleni =	6	end
		if mtype ==	0x00A2	then msgleni =	6	end
		if mtype ==	0x00A4	then msgleni =	-1	end
		if mtype ==	0x00A6	then msgleni =	-1	end
		if mtype ==	0x00A7	then msgleni =	8	end
		if mtype ==	0x00A8	then msgleni =	7	end
		if mtype ==	0x00A9	then msgleni =	6	end
		if mtype ==	0x00AA	then msgleni =	7	end
		if mtype ==	0x00AB	then msgleni =	4	end
		if mtype ==	0x00AC	then msgleni =	7	end
		if mtype ==	0x00AF	then msgleni =	6	end
		if mtype ==	0x00B0	then msgleni =	8	end
		if mtype ==	0x00B1	then msgleni =	8	end
		if mtype ==	0x00B2	then msgleni =	3	end
		if mtype ==	0x00B3	then msgleni =	3	end
		if mtype ==	0x00B4	then msgleni =	-1	end
		if mtype ==	0x00B5	then msgleni =	6	end
		if mtype ==	0x00B6	then msgleni =	6	end
		if mtype ==	0x00B7	then msgleni =	-1	end
		if mtype ==	0x00B8	then msgleni =	7	end
		if mtype ==	0x00B9	then msgleni =	6	end
		if mtype ==	0x00BB	then msgleni =	5	end
		if mtype ==	0x00BC	then msgleni =	6	end
		if mtype ==	0x00BD	then msgleni =	44	end
		if mtype ==	0x00BE	then msgleni =	5	end
		if mtype ==	0x00BF	then msgleni =	3	end
		if mtype ==	0x00C0	then msgleni =	7	end
		if mtype ==	0x00C1	then msgleni =	2	end
		if mtype ==	0x00C2	then msgleni =	6	end
		if mtype ==	0x00C3	then msgleni =	8	end
		if mtype ==	0x00C4	then msgleni =	6	end
		if mtype ==	0x00C5	then msgleni =	7	end
		if mtype ==	0x00C6	then msgleni =	-1	end
		if mtype ==	0x00C7	then msgleni =	-1	end
		if mtype ==	0x00C8	then msgleni =	-1	end
		if mtype ==	0x00C9	then msgleni =	-1	end
		if mtype ==	0x00CA	then msgleni =	3	end
		if mtype ==	0x00CB	then msgleni =	3	end
		if mtype ==	0x00CC	then msgleni =	6	end
		if mtype ==	0x00CD	then msgleni =	6	end
		if mtype ==	0x00E4	then msgleni =	6	end
		if mtype ==	0x00E5	then msgleni =	26	end
		if mtype ==	0x00E6	then msgleni =	3	end
		if mtype ==	0x00E7	then msgleni =	3	end
		if mtype ==	0x00E8	then msgleni =	8	end
		if mtype ==	0x00E9	then msgleni =	19	end
		if mtype ==	0x00EB	then msgleni =	2	end
		if mtype ==	0x00EC	then msgleni =	3	end
		if mtype ==	0x00ED	then msgleni =	2	end
		if mtype ==	0x00EE	then msgleni =	2	end
		if mtype ==	0x00EF	then msgleni =	2	end
		if mtype ==	0x00F0	then msgleni =	3	end
		if mtype ==	0x00F2	then msgleni =	6	end
		if mtype ==	0x00F3	then msgleni =	8	end
		if mtype ==	0x00F4	then msgleni =	21	end
		if mtype ==	0x00F5	then msgleni =	8	end
		if mtype ==	0x00F6	then msgleni =	8	end
		if mtype ==	0x00F7	then msgleni =	2	end
		if mtype ==	0x00F8	then msgleni =	2	end
		if mtype ==	0x00F9	then msgleni =	26	end
		if mtype ==	0x00FA	then msgleni =	3	end
		if mtype ==	0x00FB	then msgleni =	-1	end
		if mtype ==	0x00FC	then msgleni =	6	end
		if mtype ==	0x00FD	then msgleni =	27	end
		if mtype ==	0x00FE	then msgleni =	30	end
		if mtype ==	0x00FF	then msgleni =	10	end
		if mtype ==	0x0100	then msgleni =	2	end
		if mtype ==	0x0101	then msgleni =	6	end
		if mtype ==	0x0102	then msgleni =	6	end
		if mtype ==	0x0103	then msgleni =	30	end
		if mtype ==	0x0104	then msgleni =	79	end
		if mtype ==	0x0105	then msgleni =	31	end
		if mtype ==	0x0106	then msgleni =	10	end
		if mtype ==	0x0107	then msgleni =	10	end
		if mtype ==	0x0108	then msgleni =	-1	end
		if mtype ==	0x0109	then msgleni =	-1	end
		if mtype ==	0x010C	then msgleni =	6	end
		if mtype ==	0x010E	then msgleni =	11	end
		if mtype ==	0x010F	then msgleni =	-1	end
		if mtype ==	0x0110	then msgleni =	10	end
		if mtype ==	0x0112	then msgleni =	4	end
		if mtype ==	0x0113	then msgleni =	10	end
		if mtype ==	0x0116	then msgleni =	10	end
		if mtype ==	0x0119	then msgleni =	13	end
		if mtype ==	0x011B	then msgleni =	20	end
		if mtype ==	0x0139	then msgleni =	16	end
		if mtype ==	0x013A	then msgleni =	4	end
		if mtype ==	0x013B	then msgleni =	4	end
		if mtype ==	0x013C	then msgleni =	4	end
		if mtype ==	0x0141	then msgleni =	14	end
		if mtype ==	0x0142	then msgleni =	6	end
		if mtype ==	0x0143	then msgleni =	10	end
		if mtype ==	0x0146	then msgleni =	6	end
		if mtype ==	0x0148	then msgleni =	8	end
		if mtype ==	0x0149	then msgleni =	9	end
		if mtype ==	0x014C	then msgleni =	-1	end
		if mtype ==	0x014D	then msgleni =	2	end
		if mtype ==	0x014E	then msgleni =	6	end
		if mtype ==	0x014F	then msgleni =	6	end
		if mtype ==	0x0151	then msgleni =	6	end
		if mtype ==	0x0152	then msgleni =	-1	end
		if mtype ==	0x0153	then msgleni =	-1	end
		if mtype ==	0x0154	then msgleni =	-1	end
		if mtype ==	0x0155	then msgleni =	-1	end
		if mtype ==	0x0156	then msgleni =	-1	end
		if mtype ==	0x0159	then msgleni =	54	end
		if mtype ==	0x015A	then msgleni =	66	end
		if mtype ==	0x015B	then msgleni =	54	end
		if mtype ==	0x015C	then msgleni =	90	end
		if mtype ==	0x015D	then msgleni =	42	end
		if mtype ==	0x015E	then msgleni =	6	end
		if mtype ==	0x0160	then msgleni =	-1	end
		if mtype ==	0x0161	then msgleni =	-1	end
		if mtype ==	0x0162	then msgleni =	-1	end
		if mtype ==	0x0163	then msgleni =	-1	end
		if mtype ==	0x0165	then msgleni =	30	end
		if mtype ==	0x0166	then msgleni =	-1	end
		if mtype ==	0x0167	then msgleni =	3	end
		if mtype ==	0x0168	then msgleni =	14	end
		if mtype ==	0x0169	then msgleni =	3	end
		if mtype ==	0x016A	then msgleni =	30	end
		if mtype ==	0x016B	then msgleni =	10	end
		if mtype ==	0x016C	then msgleni =	43	end
		if mtype ==	0x016D	then msgleni =	14	end
		if mtype ==	0x016E	then msgleni =	186	end
		if mtype ==	0x016F	then msgleni =	182	end
		if mtype ==	0x0170	then msgleni =	14	end
		if mtype ==	0x0171	then msgleni =	30	end
		if mtype ==	0x0172	then msgleni =	10	end
		if mtype ==	0x0173	then msgleni =	3	end
		if mtype ==	0x0174	then msgleni =	-1	end
		if mtype ==	0x017E	then msgleni =	-1	end
		if mtype ==	0x017F	then msgleni =	-1	end
		if mtype ==	0x0180	then msgleni =	6	end
		if mtype ==	0x0181	then msgleni =	3	end
		if mtype ==	0x0183	then msgleni =	10	end
		if mtype ==	0x0184	then msgleni =	10	end
		if mtype ==	0x018A	then msgleni =	4	end
		if mtype ==	0x018B	then msgleni =	4	end
		if mtype ==	0x0190	then msgleni =	90	end
		if mtype ==	0x0195	then msgleni =	102	end
		if mtype ==	0x0196	then msgleni =	9	end
		if mtype ==	0x019B	then msgleni =	10	end
		if mtype ==	0x019C	then msgleni =	4	end
		if mtype ==	0x019D	then msgleni =	6	end
		if mtype ==	0x01B1	then msgleni =	7	end
		if mtype ==	0x01B6	then msgleni =	114	end
		if mtype ==	0x01C8	then msgleni =	13	end
		if mtype ==	0x01D4	then msgleni =	6	end
		if mtype ==	0x01D5	then msgleni =	8	end
		if mtype ==	0x01D7	then msgleni =	11	end
		if mtype ==	0x01D8	then msgleni =	54	end
		if mtype ==	0x01D9	then msgleni =	53	end
		if mtype ==	0x01DA	then msgleni =	60	end
		if mtype ==	0x01DE	then msgleni =	33	end
		if mtype ==	0x01EE	then msgleni =	-1	end
		if mtype ==	0x01F0	then msgleni =	-1	end
		if mtype ==	0x020C	then msgleni =	10	end
		if mtype ==	0x7530	then msgleni =	2	end
		if mtype ==	0x7531	then msgleni =	10	end
		if mtype ==	0x0000	then msgleni =	10	end
		if mtype ==	0x0074	then msgleni =	3	end
		if mtype ==	0x0075	then msgleni =	-1	end
		if mtype ==	0x0076	then msgleni =	9	end
		if mtype ==	0x0077	then msgleni =	5	end
		if mtype ==	0x0079	then msgleni =	53	end
		if mtype ==	0x007A	then msgleni =	58	end
		if mtype ==	0x0082	then msgleni =	2	end
		if mtype ==	0x0083	then msgleni =	2	end
		if mtype ==	0x0084	then msgleni =	2	end
		if mtype ==	0x008B	then msgleni =	23	end
		if mtype ==	0x0093	then msgleni =	2	end
		if mtype ==	0x00A3	then msgleni =	-1	end
		if mtype ==	0x00A5	then msgleni =	-1	end
		if mtype ==	0x00AE	then msgleni =	-1	end
		if mtype ==	0x00BA	then msgleni =	2	end
		if mtype ==	0x00CE	then msgleni =	2	end
		if mtype ==	0x00CF	then msgleni =	27	end
		if mtype ==	0x00D0	then msgleni =	3	end
		if mtype ==	0x00D1	then msgleni =	4	end
		if mtype ==	0x00D2	then msgleni =	4	end
		if mtype ==	0x00D3	then msgleni =	2	end
		if mtype ==	0x00D4	then msgleni =	-1	end
		if mtype ==	0x00D5	then msgleni =	-1	end
		if mtype ==	0x00D6	then msgleni =	3	end
		if mtype ==	0x00D7	then msgleni =	-1	end
		if mtype ==	0x00D8	then msgleni =	6	end
		if mtype ==	0x00D9	then msgleni =	14	end
		if mtype ==	0x00DA	then msgleni =	3	end
		if mtype ==	0x00DB	then msgleni =	-1	end
		if mtype ==	0x00DC	then msgleni =	28	end
		if mtype ==	0x00DD	then msgleni =	29	end
		if mtype ==	0x00DE	then msgleni =	-1	end
		if mtype ==	0x00DF	then msgleni =	-1	end
		if mtype ==	0x00E0	then msgleni =	30	end
		if mtype ==	0x00E1	then msgleni =	30	end
		if mtype ==	0x00E2	then msgleni =	26	end
		if mtype ==	0x00E3	then msgleni =	2	end
		if mtype ==	0x00EA	then msgleni =	5	end
		if mtype ==	0x00F1	then msgleni =	2	end
		if mtype ==	0x010A	then msgleni =	4	end
		if mtype ==	0x010B	then msgleni =	6	end
		if mtype ==	0x010D	then msgleni =	2	end
		if mtype ==	0x0111	then msgleni =	39	end
		if mtype ==	0x0114	then msgleni =	31	end
		if mtype ==	0x0115	then msgleni =	35	end
		if mtype ==	0x0117	then msgleni =	18	end
		if mtype ==	0x0118	then msgleni =	2	end
		if mtype ==	0x011A	then msgleni =	15	end
		if mtype ==	0x011C	then msgleni =	68	end
		if mtype ==	0x011D	then msgleni =	2	end
		if mtype ==	0x011E	then msgleni =	3	end
		if mtype ==	0x011F	then msgleni =	16	end
		if mtype ==	0x0120	then msgleni =	6	end
		if mtype ==	0x0121	then msgleni =	14	end
		if mtype ==	0x0122	then msgleni =	-1	end
		if mtype ==	0x0123	then msgleni =	-1	end
		if mtype ==	0x0124	then msgleni =	21	end
		if mtype ==	0x0125	then msgleni =	8	end
		if mtype ==	0x0126	then msgleni =	8	end
		if mtype ==	0x0127	then msgleni =	8	end
		if mtype ==	0x0128	then msgleni =	8	end
		if mtype ==	0x0129	then msgleni =	8	end
		if mtype ==	0x012A	then msgleni =	2	end
		if mtype ==	0x012B	then msgleni =	2	end
		if mtype ==	0x012C	then msgleni =	3	end
		if mtype ==	0x012D	then msgleni =	4	end
		if mtype ==	0x012E	then msgleni =	2	end
		if mtype ==	0x012F	then msgleni =	-1	end
		if mtype ==	0x0130	then msgleni =	6	end
		if mtype ==	0x0131	then msgleni =	86	end
		if mtype ==	0x0132	then msgleni =	6	end
		if mtype ==	0x0133	then msgleni =	-1	end
		if mtype ==	0x0134	then msgleni =	-1	end
		if mtype ==	0x0135	then msgleni =	7	end
		if mtype ==	0x0136	then msgleni =	-1	end
		if mtype ==	0x0137	then msgleni =	6	end
		if mtype ==	0x0138	then msgleni =	3	end
		if mtype ==	0x013D	then msgleni =	6	end
		if mtype ==	0x013E	then msgleni =	24	end
		if mtype ==	0x013F	then msgleni =	26	end
		if mtype ==	0x0140	then msgleni =	22	end
		if mtype ==	0x0144	then msgleni =	23	end
		if mtype ==	0x0145	then msgleni =	19	end
		if mtype ==	0x0147	then msgleni =	39	end
		if mtype ==	0x014A	then msgleni =	6	end
		if mtype ==	0x014B	then msgleni =	27	end
		if mtype ==	0x0150	then msgleni =	110	end
		if mtype ==	0x0157	then msgleni =	6	end
		if mtype ==	0x0158	then msgleni =	-1	end
		if mtype ==	0x015F	then msgleni =	42	end
		if mtype ==	0x0164	then msgleni =	-1	end
		if mtype ==	0x0175	then msgleni =	6	end
		if mtype ==	0x0176	then msgleni =	106	end
		if mtype ==	0x0177	then msgleni =	-1	end
		if mtype ==	0x0178	then msgleni =	4	end
		if mtype ==	0x0179	then msgleni =	5	end
		if mtype ==	0x017A	then msgleni =	4	end
		if mtype ==	0x017B	then msgleni =	-1	end
		if mtype ==	0x017C	then msgleni =	6	end
		if mtype ==	0x017D	then msgleni =	7	end
		if mtype ==	0x0182	then msgleni =	106	end
		if mtype ==	0x0185	then msgleni =	34	end
		if mtype ==	0x0187	then msgleni =	6	end
		if mtype ==	0x0188	then msgleni =	8	end
		if mtype ==	0x0189	then msgleni =	4	end
		if mtype ==	0x018C	then msgleni =	29	end
		if mtype ==	0x018D	then msgleni =	-1	end
		if mtype ==	0x018E	then msgleni =	10	end
		if mtype ==	0x018F	then msgleni =	6	end
		if mtype ==	0x0191	then msgleni =	86	end
		if mtype ==	0x0192	then msgleni =	24	end
		if mtype ==	0x0193	then msgleni =	6	end
		if mtype ==	0x0194	then msgleni =	30	end
		if mtype ==	0x0197	then msgleni =	4	end
		if mtype ==	0x0198	then msgleni =	8	end
		if mtype ==	0x0199	then msgleni =	4	end
		if mtype ==	0x019A	then msgleni =	14	end
		if mtype ==	0x019E	then msgleni =	2	end
		if mtype ==	0x019F	then msgleni =	6	end
		if mtype ==	0x01A0	then msgleni =	3	end
		if mtype ==	0x01A1	then msgleni =	3	end
		if mtype ==	0x01A2	then msgleni =	35	end
		if mtype ==	0x01A3	then msgleni =	5	end
		if mtype ==	0x01A4	then msgleni =	11	end
		if mtype ==	0x01A5	then msgleni =	26	end
		if mtype ==	0x01A6	then msgleni =	-1	end
		if mtype ==	0x01A7	then msgleni =	4	end
		if mtype ==	0x01A8	then msgleni =	4	end
		if mtype ==	0x01A9	then msgleni =	6	end
		if mtype ==	0x01AA	then msgleni =	10	end
		if mtype ==	0x01AB	then msgleni =	12	end
		if mtype ==	0x01AC	then msgleni =	6	end
		if mtype ==	0x01AD	then msgleni =	-1	end
		if mtype ==	0x01AE	then msgleni =	4	end
		if mtype ==	0x01AF	then msgleni =	4	end
		if mtype ==	0x01B0	then msgleni =	11	end
		if mtype ==	0x01B2	then msgleni =	-1	end
		if mtype ==	0x01B3	then msgleni =	67	end
		if mtype ==	0x01B4	then msgleni =	12	end
		if mtype ==	0x01B5	then msgleni =	18	end
		if mtype ==	0x01B7	then msgleni =	6	end
		if mtype ==	0x01B8	then msgleni =	3	end
		if mtype ==	0x01B9	then msgleni =	6	end
		if mtype ==	0x01BA	then msgleni =	26	end
		if mtype ==	0x01BB	then msgleni =	26	end
		if mtype ==	0x01BC	then msgleni =	26	end
		if mtype ==	0x01BD	then msgleni =	26	end
		if mtype ==	0x01BE	then msgleni =	2	end
		if mtype ==	0x01BF	then msgleni =	3	end
		if mtype ==	0x01C0	then msgleni =	2	end
		if mtype ==	0x01C1	then msgleni =	14	end
		if mtype ==	0x01C2	then msgleni =	10	end
		if mtype ==	0x01C3	then msgleni =	-1	end
		if mtype ==	0x01C4	then msgleni =	22	end
		if mtype ==	0x01C5	then msgleni =	22	end
		if mtype ==	0x01C6	then msgleni =	4	end
		if mtype ==	0x01C7	then msgleni =	2	end
		if mtype ==	0x01C9	then msgleni =	97	end
		if mtype ==	0x01CB	then msgleni =	9	end
		if mtype ==	0x01CC	then msgleni =	9	end
		if mtype ==	0x01CD	then msgleni =	29	end
		if mtype ==	0x01CE	then msgleni =	6	end
		if mtype ==	0x01CF	then msgleni =	28	end
		if mtype ==	0x01D0	then msgleni =	8	end
		if mtype ==	0x01D1	then msgleni =	14	end
		if mtype ==	0x01D2	then msgleni =	10	end
		if mtype ==	0x01D3	then msgleni =	35	end
		if mtype ==	0x01D6	then msgleni =	4	end
		if mtype ==	0x01DB	then msgleni =	2	end
		if mtype ==	0x01DC	then msgleni =	-1	end
		if mtype ==	0x01DD	then msgleni =	47	end
		if mtype ==	0x01DF	then msgleni =	6	end
		if mtype ==	0x01E0	then msgleni =	30	end
		if mtype ==	0x01E1	then msgleni =	8	end
		if mtype ==	0x01E2	then msgleni =	34	end
		if mtype ==	0x01E3	then msgleni =	14	end
		if mtype ==	0x01E4	then msgleni =	2	end
		if mtype ==	0x01E5	then msgleni =	6	end
		if mtype ==	0x01E6	then msgleni =	26	end
		if mtype ==	0x01E7	then msgleni =	2	end
		if mtype ==	0x01E8	then msgleni =	28	end
		if mtype ==	0x01E9	then msgleni =	81	end
		if mtype ==	0x01EA	then msgleni =	6	end
		if mtype ==	0x01EB	then msgleni =	10	end
		if mtype ==	0x01EC	then msgleni =	26	end
		if mtype ==	0x01ED	then msgleni =	2	end
		if mtype ==	0x01EF	then msgleni =	-1	end
		if mtype ==	0x01F1	then msgleni =	-1	end
		if mtype ==	0x01F2	then msgleni =	20	end
		if mtype ==	0x01F3	then msgleni =	10	end
		if mtype ==	0x01F4	then msgleni =	32	end
		if mtype ==	0x01F5	then msgleni =	9	end
		if mtype ==	0x01F6	then msgleni =	34	end
		if mtype ==	0x01F7	then msgleni =	14	end
		if mtype ==	0x01F8	then msgleni =	2	end
		if mtype ==	0x01F9	then msgleni =	6	end
		if mtype ==	0x01FA	then msgleni =	48	end
		if mtype ==	0x01FB	then msgleni =	56	end
		if mtype ==	0x01FC	then msgleni =	-1	end
		if mtype ==	0x01FD	then msgleni =	4	end
		if mtype ==	0x01FE	then msgleni =	5	end
		if mtype ==	0x01FF	then msgleni =	10	end
		if mtype ==	0x0200	then msgleni =	26	end
		if mtype ==	0x0204	then msgleni =	18	end
		if mtype ==	0x020B	then msgleni =	19	end
		if mtype ==	0x2709	then msgleni =	2	end
		if mtype ==	0x2711	then msgleni =	3	end
		if mtype ==	0x2712	then msgleni =	19	end
		if mtype ==	0x2713	then msgleni =	51	end
		if mtype ==	0x2714	then msgleni =	6	end
		if mtype ==	0x2716	then msgleni =	6	end
		if mtype ==	0x2717	then msgleni =	50	end
		if mtype ==	0x2722	then msgleni =	86	end
		if mtype ==	0x2723	then msgleni =	7	end
		if mtype ==	0x2724	then msgleni =	10	end
		if mtype ==	0x2727	then msgleni =	6	end
		if mtype ==	0x2731	then msgleni =	11	end
		if mtype ==	0x2740	then msgleni =	54	end
		if mtype ==	0x2741	then msgleni =	7	end
			 
	    --ukupna velicina TCP segmenta
	    velicina_tereta=buffer:len()
		
		--ucitaj i ispisi tip poruke i duljinu na osnovu prva dva bajta 
		subtree:add_le(msg_type,buffer(pocetak,2)):append_text(mtype_str)
		subtree:add_le("Deklarirana veličina: ",buffer(pocetak,2)):append_text(msgleni)
		subtree:add_le("Velicina tereta: ",buffer:len())
		
		--spremamo velicinu ostalog tereta kako bismo odredili postoji li još paketa u segmentu
		--varijabla ce nam poslije posluziti kao uvjet za zavrsetak while petlje 
		velicina_ostalog_tereta=velicina_tereta-msgleni
		subtree:add_le("Velicina ostalog tereta: ",velicina_ostalog_tereta)
		
		--prvjera ako postoji jos paketa u segmentu 
		if velicina_tereta ~= msgleni then
				iskoristeni_dio=0
				--petlja koja trazi ostale pakete i identificira ih na temelju prva dva bajta
				while velicina_ostalog_tereta>0 do
					--biljezimo koji smo dio u segmentu iskoristili kako bismo od tog dijela
					--pa dalje odredili sljedeci paket
					iskoristeni_dio=iskoristeni_dio+msgleni
					mtype=buffer(msgleni,2):le_uint()
					if mtype == 	0x0061	 then mtype_str = "	CMSG_CHAR_PASSWORD_CHANGE	 "  end
					if mtype == 	0x0062	 then mtype_str = "	SMSG_CHAR_PASSWORD_RESPONSE	 " end
					if mtype == 	0x0063	 then mtype_str = "	SMSG_UPDATE_HOST	 " end
					if mtype == 	0x0064	 then mtype_str = "	(hard-coded)	 " end
					if mtype == 	0x0065	 then mtype_str = "	CMSG_CHAR_SERVER_CONNECT	 " end
					if mtype == 	0x0066	 then mtype_str = "	CMSG_CHAR_SELECT	 " end
					if mtype == 	0x0067	 then mtype_str = "	CMSG_CHAR_CREATE	 " end
					if mtype == 	0x0068	 then mtype_str = "	CMSG_CHAR_DELETE	 " end
					if mtype == 	0x0069	 then mtype_str = "	SMSG_LOGIN_DATA	 " end
					if mtype == 	0x006A	 then mtype_str = "	SMSG_LOGIN_ERROR	 " end
					if mtype == 	0x006B	 then mtype_str = "	SMSG_CHAR_LOGIN	 " end
					if mtype == 	0x006C	 then mtype_str = "	SMSG_CHAR_LOGIN_ERROR	 " end
					if mtype == 	0x006D	 then mtype_str = "	SMSG_CHAR_CREATE_SUCCEEDED	 " end
					if mtype == 	0x006E	 then mtype_str = "	SMSG_CHAR_CREATE_FAILED	 " end
					if mtype == 	0x006F	 then mtype_str = "	SMSG_CHAR_DELETE_SUCCEEDED	 " end
					if mtype == 	0x0070	 then mtype_str = "	SMSG_CHAR_DELETE_FAILED	 " end
					if mtype == 	0x0071	 then mtype_str = "	SMSG_CHAR_MAP_INFO	 " end
					if mtype == 	0x0072	 then mtype_str = "	CMSG_MAP_SERVER_CONNECT	 " end
					if mtype == 	0x0073	 then mtype_str = "	SMSG_MAP_LOGIN_SUCCESS	 " end
					if mtype == 	0x0078	 then mtype_str = "	SMSG_BEING_VISIBLE	 " end
					if mtype == 	0x007B	 then mtype_str = "	SMSG_BEING_MOVE	 " end
					if mtype == 	0x007C	 then mtype_str = "	SMSG_BEING_SPAWN	 " end
					if mtype == 	0x007D	 then mtype_str = "	CMSG_MAP_LOADED	 " end
					if mtype == 	0x007E	 then mtype_str = "	CMSG_CLIENT_PING	 " end
					if mtype == 	0x007F	 then mtype_str = "	SMSG_SERVER_PING	 " end
					if mtype == 	0x0080	 then mtype_str = "	SMSG_BEING_REMOVE	 " end
					if mtype == 	0x0081	 then mtype_str = "	SMSG_CONNECTION_PROBLEM	 " end
					if mtype == 	0x0085	 then mtype_str = "	CMSG_PLAYER_CHANGE_DEST	 " end
					if mtype == 	0x0086	 then mtype_str = "	SMSG_BEING_MOVE2	 " end
					if mtype == 	0x0087	 then mtype_str = "	SMSG_WALK_RESPONSE	 " end
					if mtype == 	0x0088	 then mtype_str = "	SMSG_PLAYER_STOP	 " end
					if mtype == 	0x0089	 then mtype_str = "	CMSG_PLAYER_CHANGE_ACT	 " end
					if mtype == 	0x0089	 then mtype_str = "	CMSG_PLAYER_ATTACK	 " end
					if mtype == 	0x008A	 then mtype_str = "	SMSG_BEING_ACTION	 " end
					if mtype == 	0x008C	 then mtype_str = "	CMSG_CHAT_MESSAGE	 " end
					if mtype == 	0x008D	 then mtype_str = "	SMSG_BEING_CHAT	 " end
					if mtype == 	0x008E	 then mtype_str = "	SMSG_PLAYER_CHAT	 " end
					if mtype == 	0x0090	 then mtype_str = "	CMSG_NPC_TALK	 " end
					if mtype == 	0x0091	 then mtype_str = "	SMSG_PLAYER_WARP	 " end
					if mtype == 	0x0092	 then mtype_str = "	SMSG_CHANGE_MAP_SERVER	 " end
					if mtype == 	0x0094	 then mtype_str = "	(hard-coded)	 " end
					if mtype == 	0x0095	 then mtype_str = "	SMSG_BEING_NAME_RESPONSE	 " end
					if mtype == 	0x0096	 then mtype_str = "	CMSG_CHAT_WHISPER	 " end
					if mtype == 	0x0097	 then mtype_str = "	SMSG_WHISPER	 " end
					if mtype == 	0x0098	 then mtype_str = "	SMSG_WHISPER_RESPONSE	 " end
					if mtype == 	0x0099	 then mtype_str = "	CMSG_ADMIN_ANNOUNCE	 " end
					if mtype == 	0x0099	 then mtype_str = "	CMSG_CHAT_ANNOUNCE	 " end
					if mtype == 	0x009A	 then mtype_str = "	SMSG_GM_CHAT	 " end
					if mtype == 	0x009B	 then mtype_str = "	CMSG_PLAYER_CHANGE_DIR	 " end
					if mtype == 	0x009C	 then mtype_str = "	SMSG_BEING_CHANGE_DIRECTION	 " end
					if mtype == 	0x009D	 then mtype_str = "	SMSG_ITEM_VISIBLE	 " end
					if mtype == 	0x009E	 then mtype_str = "	SMSG_ITEM_DROPPED	 " end
					if mtype == 	0x009F	 then mtype_str = "	CMSG_ITEM_PICKUP	 " end
					if mtype == 	0x00A0	 then mtype_str = "	SMSG_PLAYER_INVENTORY_ADD	 " end
					if mtype == 	0x00A1	 then mtype_str = "	SMSG_ITEM_REMOVE	 " end
					if mtype == 	0x00A2	 then mtype_str = "	CMSG_PLAYER_INVENTORY_DROP	 " end
					if mtype == 	0x00A4	 then mtype_str = "	SMSG_PLAYER_EQUIPMENT	 " end
					if mtype == 	0x00A6	 then mtype_str = "	SMSG_PLAYER_STORAGE_EQUIP	 " end
					if mtype == 	0x00A7	 then mtype_str = "	CMSG_PLAYER_INVENTORY_USE	 " end
					if mtype == 	0x00A8	 then mtype_str = "	SMSG_ITEM_USE_RESPONSE	 " end
					if mtype == 	0x00A9	 then mtype_str = "	CMSG_PLAYER_EQUIP	 " end
					if mtype == 	0x00AA	 then mtype_str = "	SMSG_PLAYER_EQUIP	 " end
					if mtype == 	0x00AB	 then mtype_str = "	CMSG_PLAYER_UNEQUIP	 " end
					if mtype == 	0x00AC	 then mtype_str = "	SMSG_PLAYER_UNEQUIP	 " end
					if mtype == 	0x00AF	 then mtype_str = "	SMSG_PLAYER_INVENTORY_REMOVE	 " end
					if mtype == 	0x00B0	 then mtype_str = "	SMSG_PLAYER_STAT_UPDATE_1	 " end
					if mtype == 	0x00B1	 then mtype_str = "	SMSG_PLAYER_STAT_UPDATE_2	 " end
					if mtype == 	0x00B2	 then mtype_str = "	CMSG_PLAYER_RESTART	 " end
					if mtype == 	0x00B3	 then mtype_str = "	SMSG_CHAR_SWITCH_RESPONSE	 " end
					if mtype == 	0x00B4	 then mtype_str = "	SMSG_NPC_MESSAGE	 " end
					if mtype == 	0x00B5	 then mtype_str = "	SMSG_NPC_NEXT	 " end
					if mtype == 	0x00B6	 then mtype_str = "	SMSG_NPC_CLOSE	 " end
					if mtype == 	0x00B7	 then mtype_str = "	SMSG_NPC_CHOICE	 " end
					if mtype == 	0x00B8	 then mtype_str = "	CMSG_NPC_LIST_CHOICE	 " end
					if mtype == 	0x00B9	 then mtype_str = "	CMSG_NPC_NEXT_REQUEST	 " end
					if mtype == 	0x00BB	 then mtype_str = "	CMSG_STAT_UPDATE_REQUEST	 " end
					if mtype == 	0x00BC	 then mtype_str = "	SMSG_PLAYER_STAT_UPDATE_4	 " end
					if mtype == 	0x00BD	 then mtype_str = "	SMSG_PLAYER_STAT_UPDATE_5	 " end
					if mtype == 	0x00BE	 then mtype_str = "	SMSG_PLAYER_STAT_UPDATE_6	 " end
					if mtype == 	0x00BF	 then mtype_str = "	CMSG_PLAYER_EMOTE	 " end
					if mtype == 	0x00C0	 then mtype_str = "	SMSG_BEING_EMOTION	 " end
					if mtype == 	0x00C1	 then mtype_str = "	CMSG_WHO_REQUEST	 " end
					if mtype == 	0x00C1	 then mtype_str = "	CMSG_CHAT_WHO	 " end
					if mtype == 	0x00C2	 then mtype_str = "	SMSG_WHO_ANSWER	 " end
					if mtype == 	0x00C3	 then mtype_str = "	SMSG_BEING_CHANGE_LOOKS	 " end
					if mtype == 	0x00C4	 then mtype_str = "	SMSG_NPC_BUY_SELL_CHOICE	 " end
					if mtype == 	0x00C5	 then mtype_str = "	CMSG_NPC_BUY_SELL_REQUEST	 " end
					if mtype == 	0x00C6	 then mtype_str = "	SMSG_NPC_BUY	 " end
					if mtype == 	0x00C7	 then mtype_str = "	SMSG_NPC_SELL	 " end
					if mtype == 	0x00C8	 then mtype_str = "	CMSG_NPC_BUY_REQUEST	 " end
					if mtype == 	0x00C9	 then mtype_str = "	CMSG_NPC_SELL_REQUEST	 " end
					if mtype == 	0x00CA	 then mtype_str = "	SMSG_NPC_BUY_RESPONSE	 " end
					if mtype == 	0x00CB	 then mtype_str = "	SMSG_NPC_SELL_RESPONSE	 " end
					if mtype == 	0x00CC	 then mtype_str = "	CMSG_ADMIN_KICK	 " end
					if mtype == 	0x00CD	 then mtype_str = "	SMSG_ADMIN_KICK_ACK	 " end
					if mtype == 	0x00E4	 then mtype_str = "	CMSG_TRADE_REQUEST	 " end
					if mtype == 	0x00E5	 then mtype_str = "	SMSG_TRADE_REQUEST	 " end
					if mtype == 	0x00E6	 then mtype_str = "	CMSG_TRADE_RESPONSE	 " end
					if mtype == 	0x00E7	 then mtype_str = "	SMSG_TRADE_RESPONSE	 " end
					if mtype == 	0x00E8	 then mtype_str = "	CMSG_TRADE_ITEM_ADD_REQUEST	 " end
					if mtype == 	0x00E9	 then mtype_str = "	SMSG_TRADE_ITEM_ADD	 " end
					if mtype == 	0x00EB	 then mtype_str = "	CMSG_TRADE_ADD_COMPLETE	 " end
					if mtype == 	0x00EC	 then mtype_str = "	SMSG_TRADE_OK	 " end
					if mtype == 	0x00ED	 then mtype_str = "	CMSG_TRADE_CANCEL_REQUEST	 " end
					if mtype == 	0x00EE	 then mtype_str = "	SMSG_TRADE_CANCEL	 " end
					if mtype == 	0x00EF	 then mtype_str = "	CMSG_TRADE_OK	 " end
					if mtype == 	0x00F0	 then mtype_str = "	SMSG_TRADE_COMPLETE	 " end
					if mtype == 	0x00F2	 then mtype_str = "	SMSG_PLAYER_STORAGE_STATUS	 " end
					if mtype == 	0x00F3	 then mtype_str = "	CMSG_MOVE_TO_STORAGE	 " end
					if mtype == 	0x00F4	 then mtype_str = "	SMSG_PLAYER_STORAGE_ADD	 " end
					if mtype == 	0x00F5	 then mtype_str = "	CSMG_MOVE_FROM_STORAGE	 " end
					if mtype == 	0x00F6	 then mtype_str = "	SMSG_PLAYER_STORAGE_REMOVE	 " end
					if mtype == 	0x00F7	 then mtype_str = "	CMSG_CLOSE_STORAGE	 " end
					if mtype == 	0x00F8	 then mtype_str = "	SMSG_PLAYER_STORAGE_CLOSE	 " end
					if mtype == 	0x00F9	 then mtype_str = "	CMSG_PARTY_CREATE	 " end
					if mtype == 	0x00FA	 then mtype_str = "	SMSG_PARTY_CREATE	 " end
					if mtype == 	0x00FB	 then mtype_str = "	SMSG_PARTY_INFO	 " end
					if mtype == 	0x00FC	 then mtype_str = "	CMSG_PARTY_INVITE	 " end
					if mtype == 	0x00FD	 then mtype_str = "	SMSG_PARTY_INVITE_RESPONSE	 " end
					if mtype == 	0x00FE	 then mtype_str = "	SMSG_PARTY_INVITED	 " end
					if mtype == 	0x00FF	 then mtype_str = "	CMSG_PARTY_INVITED	 " end
					if mtype == 	0x0100	 then mtype_str = "	CMSG_PARTY_LEAVE	 " end
					if mtype == 	0x0101	 then mtype_str = "	SMSG_PARTY_SETTINGS	 " end
					if mtype == 	0x0102	 then mtype_str = "	CMSG_PARTY_SETTINGS	 " end
					if mtype == 	0x0103	 then mtype_str = "	CMSG_PARTY_KICK	 " end
					if mtype == 	0x0104	 then mtype_str = "	SMSG_PARTY_MOVE	 " end
					if mtype == 	0x0105	 then mtype_str = "	SMSG_PARTY_LEAVE	 " end
					if mtype == 	0x0106	 then mtype_str = "	SMSG_PARTY_UPDATE_HP	 " end
					if mtype == 	0x0107	 then mtype_str = "	SMSG_PARTY_UPDATE_COORDS	 " end
					if mtype == 	0x0108	 then mtype_str = "	CMSG_PARTY_MESSAGE	 " end
					if mtype == 	0x0109	 then mtype_str = "	SMSG_PARTY_MESSAGE	 " end
					if mtype == 	0x010C	 then mtype_str = "	SMSG_MVP	 " end
					if mtype == 	0x010E	 then mtype_str = "	SMSG_PLAYER_SKILL_UP	 " end
					if mtype == 	0x010E	 then mtype_str = "	SMSG_GUILD_SKILL_UP	 " end
					if mtype == 	0x010F	 then mtype_str = "	SMSG_PLAYER_SKILLS	 " end
					if mtype == 	0x0110	 then mtype_str = "	SMSG_SKILL_FAILED	 " end
					if mtype == 	0x0112	 then mtype_str = "	CMSG_SKILL_LEVELUP_REQUEST	 " end
					if mtype == 	0x0113	 then mtype_str = "	CMSG_SKILL_USE_BEING	 " end
					if mtype == 	0x0116	 then mtype_str = "	CMSG_SKILL_USE_POSITION	 " end
					if mtype == 	0x0119	 then mtype_str = "	SMSG_PLAYER_STATUS_CHANGE	 " end
					if mtype == 	0x011B	 then mtype_str = "	CMSG_SKILL_USE_MAP	 " end
					if mtype == 	0x0139	 then mtype_str = "	SMSG_PLAYER_MOVE_TO_ATTACK	 " end
					if mtype == 	0x013A	 then mtype_str = "	SMSG_PLAYER_ATTACK_RANGE	 " end
					if mtype == 	0x013B	 then mtype_str = "	SMSG_PLAYER_ARROW_MESSAGE	 " end
					if mtype == 	0x013C	 then mtype_str = "	SMSG_PLAYER_ARROW_EQUIP	 " end
					if mtype == 	0x0141	 then mtype_str = "	SMSG_PLAYER_STAT_UPDATE_3	 " end
					if mtype == 	0x0142	 then mtype_str = "	SMSG_NPC_INT_INPUT	 " end
					if mtype == 	0x0143	 then mtype_str = "	CMSG_NPC_INT_RESPONSE	 " end
					if mtype == 	0x0146	 then mtype_str = "	CMSG_NPC_CLOSE	 " end
					if mtype == 	0x0148	 then mtype_str = "	SMSG_BEING_RESURRECT	 " end
					if mtype == 	0x0149	 then mtype_str = "	CMSG_ADMIN_MUTE	 " end
					if mtype == 	0x014C	 then mtype_str = "	SMSG_GUILD_ALIANCE_INFO	 " end
					if mtype == 	0x014D	 then mtype_str = "	CMSG_GUILD_CHECK_MASTER	 " end
					if mtype == 	0x014E	 then mtype_str = "	SMSG_GUILD_MASTER_OR_MEMBER	 " end
					if mtype == 	0x014F	 then mtype_str = "	CMSG_GUILD_REQUEST_INFO	 " end
					if mtype == 	0x0151	 then mtype_str = "	CMSG_GUILD_REQUEST_EMBLEM	 " end
					if mtype == 	0x0152	 then mtype_str = "	SMSG_GUILD_EMBLEM	 " end
					if mtype == 	0x0153	 then mtype_str = "	CMSG_GUILD_CHANGE_EMBLEM	 " end
					if mtype == 	0x0154	 then mtype_str = "	SMSG_GUILD_MEMBER_LIST	 " end
					if mtype == 	0x0155	 then mtype_str = "	CMSG_GUILD_CHANGE_MEMBER_POS	 " end
					if mtype == 	0x0156	 then mtype_str = "	SMSG_GUILD_MEMBER_POS_CHANGE	 " end
					if mtype == 	0x0159	 then mtype_str = "	CMSG_GUILD_LEAVE	 " end
					if mtype == 	0x015A	 then mtype_str = "	SMSG_GUILD_LEAVE	 " end
					if mtype == 	0x015B	 then mtype_str = "	CMSG_GUILD_EXPULSION	 " end
					if mtype == 	0x015C	 then mtype_str = "	SMSG_GUILD_EXPULSION	 " end
					if mtype == 	0x015D	 then mtype_str = "	CMSG_GUILD_BREAK	 " end
					if mtype == 	0x015E	 then mtype_str = "	SMSG_GUILD_BROKEN	 " end
					if mtype == 	0x0160	 then mtype_str = "	SMSG_GUILD_POS_INFO_LIST	 " end
					if mtype == 	0x0161	 then mtype_str = "	CMSG_GUILD_CHANGE_POS_INFO	 " end
					if mtype == 	0x0162	 then mtype_str = "	SMSG_GUILD_SKILL_INFO	 " end
					if mtype == 	0x0163	 then mtype_str = "	SMSG_GUILD_EXPULSION_LIST	 " end
					if mtype == 	0x0165	 then mtype_str = "	CMSG_GUILD_CREATE	 " end
					if mtype == 	0x0166	 then mtype_str = "	SMSG_GUILD_POS_NAME_LIST	 " end
					if mtype == 	0x0167	 then mtype_str = "	SMSG_GUILD_CREATE_RESPONSE	 " end
					if mtype == 	0x0168	 then mtype_str = "	CMSG_GUILD_INVITE	 " end
					if mtype == 	0x0169	 then mtype_str = "	SMSG_GUILD_INVITE_ACK	 " end
					if mtype == 	0x016A	 then mtype_str = "	SMSG_GUILD_INVITE	 " end
					if mtype == 	0x016B	 then mtype_str = "	CMSG_GUILD_INVITE_REPLY	 " end
					if mtype == 	0x016C	 then mtype_str = "	SMSG_GUILD_POSITION_INFO	 " end
					if mtype == 	0x016D	 then mtype_str = "	SMSG_GUILD_MEMBER_LOGIN	 " end
					if mtype == 	0x016E	 then mtype_str = "	CMSG_GUILD_CHANGE_NOTICE	 " end
					if mtype == 	0x016F	 then mtype_str = "	SMSG_GUILD_NOTICE	 " end
					if mtype == 	0x0170	 then mtype_str = "	CMSG_GUILD_ALLIANCE_REQUEST	 " end
					if mtype == 	0x0171	 then mtype_str = "	SMSG_GUILD_REQ_ALLIANCE	 " end
					if mtype == 	0x0172	 then mtype_str = "	CMSG_GUILD_ALLIANCE_REPLY	 " end
					if mtype == 	0x0173	 then mtype_str = "	SMSG_GUILD_REQ_ALLIANCE_ACK	 " end
					if mtype == 	0x0174	 then mtype_str = "	SMSG_GUILD_POSITION_CHANGED	 " end
					if mtype == 	0x017E	 then mtype_str = "	CMSG_GUILD_MESSAGE	 " end
					if mtype == 	0x017F	 then mtype_str = "	SMSG_GUILD_MESSAGE	 " end
					if mtype == 	0x0180	 then mtype_str = "	CMSG_GUILD_OPPOSITION	 " end
					if mtype == 	0x0181	 then mtype_str = "	SMSG_GUILD_OPPOSITION_ACK	 " end
					if mtype == 	0x0183	 then mtype_str = "	CMSG_GUILD_ALLIANCE_DELETE	 " end
					if mtype == 	0x0184	 then mtype_str = "	SMSG_GUILD_DEL_ALLIANCE	 " end
					if mtype == 	0x018A	 then mtype_str = "	CMSG_CLIENT_QUIT	 " end
					if mtype == 	0x018B	 then mtype_str = "	SMSG_MAP_QUIT_RESPONSE	 " end
					if mtype == 	0x0190	 then mtype_str = "	CMSG_SKILL_USE_POSITION_MORE	 " end
					if mtype == 	0x0195	 then mtype_str = "	SMSG_PLAYER_GUILD_PARTY_INFO	 " end
					if mtype == 	0x0196	 then mtype_str = "	SMSG_BEING_STATUS_CHANGE	 " end
					if mtype == 	0x019B	 then mtype_str = "	SMSG_BEING_SELFEFFECT	 " end
					if mtype == 	0x019C	 then mtype_str = "	CMSG_ADMIN_LOCAL_ANNOUNCE	 " end
					if mtype == 	0x019D	 then mtype_str = "	CMSG_ADMIN_HIDE	 " end
					if mtype == 	0x01B1	 then mtype_str = "	SMSG_TRADE_ITEM_ADD_RESPONSE	 " end
					if mtype == 	0x01B6	 then mtype_str = "	SMSG_GUILD_BASIC_INFO	 " end
					if mtype == 	0x01C8	 then mtype_str = "	SMSG_PLAYER_INVENTORY_USE	 " end
					if mtype == 	0x01D4	 then mtype_str = "	SMSG_NPC_STR_INPUT	 " end
					if mtype == 	0x01D5	 then mtype_str = "	CMSG_NPC_STR_RESPONSE	 " end
					if mtype == 	0x01D7	 then mtype_str = "	SMSG_BEING_CHANGE_LOOKS2	 " end
					if mtype == 	0x01D8	 then mtype_str = "	SMSG_PLAYER_UPDATE_1	 " end
					if mtype == 	0x01D9	 then mtype_str = "	SMSG_PLAYER_UPDATE_2	 " end
					if mtype == 	0x01DA	 then mtype_str = "	SMSG_PLAYER_MOVE	 " end
					if mtype == 	0x01DE	 then mtype_str = "	SMSG_SKILL_DAMAGE	 " end
					if mtype == 	0x01EE	 then mtype_str = "	SMSG_PLAYER_INVENTORY	 " end
					if mtype == 	0x01F0	 then mtype_str = "	SMSG_PLAYER_STORAGE_ITEMS	 " end
					if mtype == 	0x020C	 then mtype_str = "	SMSG_ADMIN_IP	 " end
					if mtype == 	0x7530	 then mtype_str = "	CMSG_SERVER_VERSION_REQUEST	 " end
					if mtype == 	0x7531	 then mtype_str = "	SMSG_SERVER_VERSION_RESPONSE	 " end
					if mtype == 	0x0000	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0074	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0075	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0076	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0077	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0079	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x007A	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0082	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0083	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0084	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x008B	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0093	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00A3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00A5	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00AE	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00BA	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00CE	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00CF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00D0	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00D1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00D2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00D3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00D4	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00D5	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00D6	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00D7	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00D8	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00D9	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00DA	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00DB	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00DC	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00DD	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00DE	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00DF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00E0	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00E1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00E2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00E3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00EA	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x00F1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x010A	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x010B	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x010D	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0111	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0114	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0115	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0117	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0118	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x011A	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x011C	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x011D	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x011E	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x011F	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0120	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0121	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0122	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0123	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0124	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0125	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0126	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0127	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0128	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0129	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x012A	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x012B	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x012C	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x012D	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x012E	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x012F	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0130	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0131	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0132	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0133	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0134	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0135	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0136	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0137	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0138	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x013D	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x013E	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x013F	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0140	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0144	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0145	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0147	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x014A	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x014B	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0150	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0157	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0158	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x015F	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0164	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0175	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0176	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0177	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0178	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0179	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x017A	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x017B	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x017C	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x017D	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0182	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0185	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0187	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0188	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0189	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x018C	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x018D	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x018E	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x018F	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0191	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0192	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0193	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0194	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0197	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0198	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0199	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x019A	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x019E	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x019F	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01A0	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01A1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01A2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01A3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01A4	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01A5	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01A6	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01A7	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01A8	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01A9	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01AA	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01AB	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01AC	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01AD	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01AE	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01AF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01B0	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01B2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01B3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01B4	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01B5	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01B7	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01B8	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01B9	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01BA	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01BB	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01BC	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01BD	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01BE	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01BF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01C0	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01C1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01C2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01C3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01C4	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01C5	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01C6	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01C7	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01C9	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01CB	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01CC	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01CD	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01CE	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01CF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01D0	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01D1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01D2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01D3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01D6	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01DB	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01DC	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01DD	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01DF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01E0	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01E1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01E2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01E3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01E4	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01E5	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01E6	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01E7	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01E8	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01E9	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01EA	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01EB	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01EC	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01ED	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01EF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01F1	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01F2	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01F3	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01F4	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01F5	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01F6	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01F7	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01F8	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01F9	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01FA	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01FB	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01FC	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01FD	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01FE	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x01FF	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0200	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x0204	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x020B	 then mtype_str = "	KATEGORIJA Free Packets	 " end
					if mtype == 	0x2709	 then mtype_str = "	Reload GM Account Request	 " end
					if mtype == 	0x2711	 then mtype_str = "	Indicator of success/failure of login	 " end
					if mtype == 	0x2712	 then mtype_str = "	Request login server to authenticate an account	 " end
					if mtype == 	0x2713	 then mtype_str = "	Authentication response from login server	 " end
					if mtype == 	0x2714	 then mtype_str = "	Current User Count	 " end
					if mtype == 	0x2716	 then mtype_str = "	Request Email and Time Limit	 " end
					if mtype == 	0x2717	 then mtype_str = "	Email and Time Limit Response	 " end
					if mtype == 	0x2722	 then mtype_str = "	Account Email Change Request	 " end
					if mtype == 	0x2723	 then mtype_str = "	Sex Change Response	 " end
					if mtype == 	0x2724	 then mtype_str = "	Change Ban Status Request	 " end
					if mtype == 	0x2727	 then mtype_str = "	Sex Change Request	 " end
					if mtype == 	0x2731	 then mtype_str = "	Change Ban Status Response	 " end
					if mtype == 	0x2740	 then mtype_str = "	Password Change Request (Internal)	 " end
					if mtype == 	0x2741	 then mtype_str = "	Password Change Response (Internal)	 " end
					if mtype ==	0x0061	then msgleni =	50	end
					if mtype ==	0x0062	then msgleni =	3	end
					if mtype ==	0x0063	then msgleni =	-1	end
					if mtype ==	0x0064	then msgleni =	55	end
					if mtype ==	0x0065	then msgleni =	17	end
					if mtype ==	0x0066	then msgleni =	3	end
					if mtype ==	0x0067	then msgleni =	37	end
					if mtype ==	0x0068	then msgleni =	46	end
					if mtype ==	0x0069	then msgleni =	-1	end
					if mtype ==	0x006A	then msgleni =	23	end
					if mtype ==	0x006B	then msgleni =	-1	end
					if mtype ==	0x006C	then msgleni =	3	end
					if mtype ==	0x006D	then msgleni =	108	end
					if mtype ==	0x006E	then msgleni =	3	end
					if mtype ==	0x006F	then msgleni =	2	end
					if mtype ==	0x0070	then msgleni =	3	end
					if mtype ==	0x0071	then msgleni =	28	end
					if mtype ==	0x0072	then msgleni =	19	end
					if mtype ==	0x0073	then msgleni =	11	end
					if mtype ==	0x0078	then msgleni =	54	end
					if mtype ==	0x007B	then msgleni =	60	end
					if mtype ==	0x007C	then msgleni =	41	end
					if mtype ==	0x007D	then msgleni =	2	end
					if mtype ==	0x007E	then msgleni =	6	end
					if mtype ==	0x007F	then msgleni =	6	end
					if mtype ==	0x0080	then msgleni =	7	end
					if mtype ==	0x0081	then msgleni =	3	end
					if mtype ==	0x0085	then msgleni =	5	end
					if mtype ==	0x0086	then msgleni =	16	end
					if mtype ==	0x0087	then msgleni =	12	end
					if mtype ==	0x0088	then msgleni =	10	end
					if mtype ==	0x0089	then msgleni =	7	end
					if mtype ==	0x008A	then msgleni =	29	end
					if mtype ==	0x008C	then msgleni =	-1	end
					if mtype ==	0x008D	then msgleni =	-1	end
					if mtype ==	0x008E	then msgleni =	-1	end
					if mtype ==	0x0090	then msgleni =	7	end
					if mtype ==	0x0091	then msgleni =	22	end
					if mtype ==	0x0092	then msgleni =	28	end
					if mtype ==	0x0094	then msgleni =	6	end
					if mtype ==	0x0095	then msgleni =	30	end
					if mtype ==	0x0096	then msgleni =	-1	end
					if mtype ==	0x0097	then msgleni =	-1	end
					if mtype ==	0x0098	then msgleni =	3	end
					if mtype ==	0x0099	then msgleni =	-1	end
					if mtype ==	0x009A	then msgleni =	-1	end
					if mtype ==	0x009B	then msgleni =	5	end
					if mtype ==	0x009C	then msgleni =	9	end
					if mtype ==	0x009D	then msgleni =	17	end
					if mtype ==	0x009E	then msgleni =	17	end
					if mtype ==	0x009F	then msgleni =	6	end
					if mtype ==	0x00A0	then msgleni =	23	end
					if mtype ==	0x00A1	then msgleni =	6	end
					if mtype ==	0x00A2	then msgleni =	6	end
					if mtype ==	0x00A4	then msgleni =	-1	end
					if mtype ==	0x00A6	then msgleni =	-1	end
					if mtype ==	0x00A7	then msgleni =	8	end
					if mtype ==	0x00A8	then msgleni =	7	end
					if mtype ==	0x00A9	then msgleni =	6	end
					if mtype ==	0x00AA	then msgleni =	7	end
					if mtype ==	0x00AB	then msgleni =	4	end
					if mtype ==	0x00AC	then msgleni =	7	end
					if mtype ==	0x00AF	then msgleni =	6	end
					if mtype ==	0x00B0	then msgleni =	8	end
					if mtype ==	0x00B1	then msgleni =	8	end
					if mtype ==	0x00B2	then msgleni =	3	end
					if mtype ==	0x00B3	then msgleni =	3	end
					if mtype ==	0x00B4	then msgleni =	-1	end
					if mtype ==	0x00B5	then msgleni =	6	end
					if mtype ==	0x00B6	then msgleni =	6	end
					if mtype ==	0x00B7	then msgleni =	-1	end
					if mtype ==	0x00B8	then msgleni =	7	end
					if mtype ==	0x00B9	then msgleni =	6	end
					if mtype ==	0x00BB	then msgleni =	5	end
					if mtype ==	0x00BC	then msgleni =	6	end
					if mtype ==	0x00BD	then msgleni =	44	end
					if mtype ==	0x00BE	then msgleni =	5	end
					if mtype ==	0x00BF	then msgleni =	3	end
					if mtype ==	0x00C0	then msgleni =	7	end
					if mtype ==	0x00C1	then msgleni =	2	end
					if mtype ==	0x00C2	then msgleni =	6	end
					if mtype ==	0x00C3	then msgleni =	8	end
					if mtype ==	0x00C4	then msgleni =	6	end
					if mtype ==	0x00C5	then msgleni =	7	end
					if mtype ==	0x00C6	then msgleni =	-1	end
					if mtype ==	0x00C7	then msgleni =	-1	end
					if mtype ==	0x00C8	then msgleni =	-1	end
					if mtype ==	0x00C9	then msgleni =	-1	end
					if mtype ==	0x00CA	then msgleni =	3	end
					if mtype ==	0x00CB	then msgleni =	3	end
					if mtype ==	0x00CC	then msgleni =	6	end
					if mtype ==	0x00CD	then msgleni =	6	end
					if mtype ==	0x00E4	then msgleni =	6	end
					if mtype ==	0x00E5	then msgleni =	26	end
					if mtype ==	0x00E6	then msgleni =	3	end
					if mtype ==	0x00E7	then msgleni =	3	end
					if mtype ==	0x00E8	then msgleni =	8	end
					if mtype ==	0x00E9	then msgleni =	19	end
					if mtype ==	0x00EB	then msgleni =	2	end
					if mtype ==	0x00EC	then msgleni =	3	end
					if mtype ==	0x00ED	then msgleni =	2	end
					if mtype ==	0x00EE	then msgleni =	2	end
					if mtype ==	0x00EF	then msgleni =	2	end
					if mtype ==	0x00F0	then msgleni =	3	end
					if mtype ==	0x00F2	then msgleni =	6	end
					if mtype ==	0x00F3	then msgleni =	8	end
					if mtype ==	0x00F4	then msgleni =	21	end
					if mtype ==	0x00F5	then msgleni =	8	end
					if mtype ==	0x00F6	then msgleni =	8	end
					if mtype ==	0x00F7	then msgleni =	2	end
					if mtype ==	0x00F8	then msgleni =	2	end
					if mtype ==	0x00F9	then msgleni =	26	end
					if mtype ==	0x00FA	then msgleni =	3	end
					if mtype ==	0x00FB	then msgleni =	-1	end
					if mtype ==	0x00FC	then msgleni =	6	end
					if mtype ==	0x00FD	then msgleni =	27	end
					if mtype ==	0x00FE	then msgleni =	30	end
					if mtype ==	0x00FF	then msgleni =	10	end
					if mtype ==	0x0100	then msgleni =	2	end
					if mtype ==	0x0101	then msgleni =	6	end
					if mtype ==	0x0102	then msgleni =	6	end
					if mtype ==	0x0103	then msgleni =	30	end
					if mtype ==	0x0104	then msgleni =	79	end
					if mtype ==	0x0105	then msgleni =	31	end
					if mtype ==	0x0106	then msgleni =	10	end
					if mtype ==	0x0107	then msgleni =	10	end
					if mtype ==	0x0108	then msgleni =	-1	end
					if mtype ==	0x0109	then msgleni =	-1	end
					if mtype ==	0x010C	then msgleni =	6	end
					if mtype ==	0x010E	then msgleni =	11	end
					if mtype ==	0x010F	then msgleni =	-1	end
					if mtype ==	0x0110	then msgleni =	10	end
					if mtype ==	0x0112	then msgleni =	4	end
					if mtype ==	0x0113	then msgleni =	10	end
					if mtype ==	0x0116	then msgleni =	10	end
					if mtype ==	0x0119	then msgleni =	13	end
					if mtype ==	0x011B	then msgleni =	20	end
					if mtype ==	0x0139	then msgleni =	16	end
					if mtype ==	0x013A	then msgleni =	4	end
					if mtype ==	0x013B	then msgleni =	4	end
					if mtype ==	0x013C	then msgleni =	4	end
					if mtype ==	0x0141	then msgleni =	14	end
					if mtype ==	0x0142	then msgleni =	6	end
					if mtype ==	0x0143	then msgleni =	10	end
					if mtype ==	0x0146	then msgleni =	6	end
					if mtype ==	0x0148	then msgleni =	8	end
					if mtype ==	0x0149	then msgleni =	9	end
					if mtype ==	0x014C	then msgleni =	-1	end
					if mtype ==	0x014D	then msgleni =	2	end
					if mtype ==	0x014E	then msgleni =	6	end
					if mtype ==	0x014F	then msgleni =	6	end
					if mtype ==	0x0151	then msgleni =	6	end
					if mtype ==	0x0152	then msgleni =	-1	end
					if mtype ==	0x0153	then msgleni =	-1	end
					if mtype ==	0x0154	then msgleni =	-1	end
					if mtype ==	0x0155	then msgleni =	-1	end
					if mtype ==	0x0156	then msgleni =	-1	end
					if mtype ==	0x0159	then msgleni =	54	end
					if mtype ==	0x015A	then msgleni =	66	end
					if mtype ==	0x015B	then msgleni =	54	end
					if mtype ==	0x015C	then msgleni =	90	end
					if mtype ==	0x015D	then msgleni =	42	end
					if mtype ==	0x015E	then msgleni =	6	end
					if mtype ==	0x0160	then msgleni =	-1	end
					if mtype ==	0x0161	then msgleni =	-1	end
					if mtype ==	0x0162	then msgleni =	-1	end
					if mtype ==	0x0163	then msgleni =	-1	end
					if mtype ==	0x0165	then msgleni =	30	end
					if mtype ==	0x0166	then msgleni =	-1	end
					if mtype ==	0x0167	then msgleni =	3	end
					if mtype ==	0x0168	then msgleni =	14	end
					if mtype ==	0x0169	then msgleni =	3	end
					if mtype ==	0x016A	then msgleni =	30	end
					if mtype ==	0x016B	then msgleni =	10	end
					if mtype ==	0x016C	then msgleni =	43	end
					if mtype ==	0x016D	then msgleni =	14	end
					if mtype ==	0x016E	then msgleni =	186	end
					if mtype ==	0x016F	then msgleni =	182	end
					if mtype ==	0x0170	then msgleni =	14	end
					if mtype ==	0x0171	then msgleni =	30	end
					if mtype ==	0x0172	then msgleni =	10	end
					if mtype ==	0x0173	then msgleni =	3	end
					if mtype ==	0x0174	then msgleni =	-1	end
					if mtype ==	0x017E	then msgleni =	-1	end
					if mtype ==	0x017F	then msgleni =	-1	end
					if mtype ==	0x0180	then msgleni =	6	end
					if mtype ==	0x0181	then msgleni =	3	end
					if mtype ==	0x0183	then msgleni =	10	end
					if mtype ==	0x0184	then msgleni =	10	end
					if mtype ==	0x018A	then msgleni =	4	end
					if mtype ==	0x018B	then msgleni =	4	end
					if mtype ==	0x0190	then msgleni =	90	end
					if mtype ==	0x0195	then msgleni =	102	end
					if mtype ==	0x0196	then msgleni =	9	end
					if mtype ==	0x019B	then msgleni =	10	end
					if mtype ==	0x019C	then msgleni =	4	end
					if mtype ==	0x019D	then msgleni =	6	end
					if mtype ==	0x01B1	then msgleni =	7	end
					if mtype ==	0x01B6	then msgleni =	114	end
					if mtype ==	0x01C8	then msgleni =	13	end
					if mtype ==	0x01D4	then msgleni =	6	end
					if mtype ==	0x01D5	then msgleni =	8	end
					if mtype ==	0x01D7	then msgleni =	11	end
					if mtype ==	0x01D8	then msgleni =	54	end
					if mtype ==	0x01D9	then msgleni =	53	end
					if mtype ==	0x01DA	then msgleni =	60	end
					if mtype ==	0x01DE	then msgleni =	33	end
					if mtype ==	0x01EE	then msgleni =	-1	end
					if mtype ==	0x01F0	then msgleni =	-1	end
					if mtype ==	0x020C	then msgleni =	10	end
					if mtype ==	0x7530	then msgleni =	2	end
					if mtype ==	0x7531	then msgleni =	10	end
					if mtype ==	0x0000	then msgleni =	10	end
					if mtype ==	0x0074	then msgleni =	3	end
					if mtype ==	0x0075	then msgleni =	-1	end
					if mtype ==	0x0076	then msgleni =	9	end
					if mtype ==	0x0077	then msgleni =	5	end
					if mtype ==	0x0079	then msgleni =	53	end
					if mtype ==	0x007A	then msgleni =	58	end
					if mtype ==	0x0082	then msgleni =	2	end
					if mtype ==	0x0083	then msgleni =	2	end
					if mtype ==	0x0084	then msgleni =	2	end
					if mtype ==	0x008B	then msgleni =	23	end
					if mtype ==	0x0093	then msgleni =	2	end
					if mtype ==	0x00A3	then msgleni =	-1	end
					if mtype ==	0x00A5	then msgleni =	-1	end
					if mtype ==	0x00AE	then msgleni =	-1	end
					if mtype ==	0x00BA	then msgleni =	2	end
					if mtype ==	0x00CE	then msgleni =	2	end
					if mtype ==	0x00CF	then msgleni =	27	end
					if mtype ==	0x00D0	then msgleni =	3	end
					if mtype ==	0x00D1	then msgleni =	4	end
					if mtype ==	0x00D2	then msgleni =	4	end
					if mtype ==	0x00D3	then msgleni =	2	end
					if mtype ==	0x00D4	then msgleni =	-1	end
					if mtype ==	0x00D5	then msgleni =	-1	end
					if mtype ==	0x00D6	then msgleni =	3	end
					if mtype ==	0x00D7	then msgleni =	-1	end
					if mtype ==	0x00D8	then msgleni =	6	end
					if mtype ==	0x00D9	then msgleni =	14	end
					if mtype ==	0x00DA	then msgleni =	3	end
					if mtype ==	0x00DB	then msgleni =	-1	end
					if mtype ==	0x00DC	then msgleni =	28	end
					if mtype ==	0x00DD	then msgleni =	29	end
					if mtype ==	0x00DE	then msgleni =	-1	end
					if mtype ==	0x00DF	then msgleni =	-1	end
					if mtype ==	0x00E0	then msgleni =	30	end
					if mtype ==	0x00E1	then msgleni =	30	end
					if mtype ==	0x00E2	then msgleni =	26	end
					if mtype ==	0x00E3	then msgleni =	2	end
					if mtype ==	0x00EA	then msgleni =	5	end
					if mtype ==	0x00F1	then msgleni =	2	end
					if mtype ==	0x010A	then msgleni =	4	end
					if mtype ==	0x010B	then msgleni =	6	end
					if mtype ==	0x010D	then msgleni =	2	end
					if mtype ==	0x0111	then msgleni =	39	end
					if mtype ==	0x0114	then msgleni =	31	end
					if mtype ==	0x0115	then msgleni =	35	end
					if mtype ==	0x0117	then msgleni =	18	end
					if mtype ==	0x0118	then msgleni =	2	end
					if mtype ==	0x011A	then msgleni =	15	end
					if mtype ==	0x011C	then msgleni =	68	end
					if mtype ==	0x011D	then msgleni =	2	end
					if mtype ==	0x011E	then msgleni =	3	end
					if mtype ==	0x011F	then msgleni =	16	end
					if mtype ==	0x0120	then msgleni =	6	end
					if mtype ==	0x0121	then msgleni =	14	end
					if mtype ==	0x0122	then msgleni =	-1	end
					if mtype ==	0x0123	then msgleni =	-1	end
					if mtype ==	0x0124	then msgleni =	21	end
					if mtype ==	0x0125	then msgleni =	8	end
					if mtype ==	0x0126	then msgleni =	8	end
					if mtype ==	0x0127	then msgleni =	8	end
					if mtype ==	0x0128	then msgleni =	8	end
					if mtype ==	0x0129	then msgleni =	8	end
					if mtype ==	0x012A	then msgleni =	2	end
					if mtype ==	0x012B	then msgleni =	2	end
					if mtype ==	0x012C	then msgleni =	3	end
					if mtype ==	0x012D	then msgleni =	4	end
					if mtype ==	0x012E	then msgleni =	2	end
					if mtype ==	0x012F	then msgleni =	-1	end
					if mtype ==	0x0130	then msgleni =	6	end
					if mtype ==	0x0131	then msgleni =	86	end
					if mtype ==	0x0132	then msgleni =	6	end
					if mtype ==	0x0133	then msgleni =	-1	end
					if mtype ==	0x0134	then msgleni =	-1	end
					if mtype ==	0x0135	then msgleni =	7	end
					if mtype ==	0x0136	then msgleni =	-1	end
					if mtype ==	0x0137	then msgleni =	6	end
					if mtype ==	0x0138	then msgleni =	3	end
					if mtype ==	0x013D	then msgleni =	6	end
					if mtype ==	0x013E	then msgleni =	24	end
					if mtype ==	0x013F	then msgleni =	26	end
					if mtype ==	0x0140	then msgleni =	22	end
					if mtype ==	0x0144	then msgleni =	23	end
					if mtype ==	0x0145	then msgleni =	19	end
					if mtype ==	0x0147	then msgleni =	39	end
					if mtype ==	0x014A	then msgleni =	6	end
					if mtype ==	0x014B	then msgleni =	27	end
					if mtype ==	0x0150	then msgleni =	110	end
					if mtype ==	0x0157	then msgleni =	6	end
					if mtype ==	0x0158	then msgleni =	-1	end
					if mtype ==	0x015F	then msgleni =	42	end
					if mtype ==	0x0164	then msgleni =	-1	end
					if mtype ==	0x0175	then msgleni =	6	end
					if mtype ==	0x0176	then msgleni =	106	end
					if mtype ==	0x0177	then msgleni =	-1	end
					if mtype ==	0x0178	then msgleni =	4	end
					if mtype ==	0x0179	then msgleni =	5	end
					if mtype ==	0x017A	then msgleni =	4	end
					if mtype ==	0x017B	then msgleni =	-1	end
					if mtype ==	0x017C	then msgleni =	6	end
					if mtype ==	0x017D	then msgleni =	7	end
					if mtype ==	0x0182	then msgleni =	106	end
					if mtype ==	0x0185	then msgleni =	34	end
					if mtype ==	0x0187	then msgleni =	6	end
					if mtype ==	0x0188	then msgleni =	8	end
					if mtype ==	0x0189	then msgleni =	4	end
					if mtype ==	0x018C	then msgleni =	29	end
					if mtype ==	0x018D	then msgleni =	-1	end
					if mtype ==	0x018E	then msgleni =	10	end
					if mtype ==	0x018F	then msgleni =	6	end
					if mtype ==	0x0191	then msgleni =	86	end
					if mtype ==	0x0192	then msgleni =	24	end
					if mtype ==	0x0193	then msgleni =	6	end
					if mtype ==	0x0194	then msgleni =	30	end
					if mtype ==	0x0197	then msgleni =	4	end
					if mtype ==	0x0198	then msgleni =	8	end
					if mtype ==	0x0199	then msgleni =	4	end
					if mtype ==	0x019A	then msgleni =	14	end
					if mtype ==	0x019E	then msgleni =	2	end
					if mtype ==	0x019F	then msgleni =	6	end
					if mtype ==	0x01A0	then msgleni =	3	end
					if mtype ==	0x01A1	then msgleni =	3	end
					if mtype ==	0x01A2	then msgleni =	35	end
					if mtype ==	0x01A3	then msgleni =	5	end
					if mtype ==	0x01A4	then msgleni =	11	end
					if mtype ==	0x01A5	then msgleni =	26	end
					if mtype ==	0x01A6	then msgleni =	-1	end
					if mtype ==	0x01A7	then msgleni =	4	end
					if mtype ==	0x01A8	then msgleni =	4	end
					if mtype ==	0x01A9	then msgleni =	6	end
					if mtype ==	0x01AA	then msgleni =	10	end
					if mtype ==	0x01AB	then msgleni =	12	end
					if mtype ==	0x01AC	then msgleni =	6	end
					if mtype ==	0x01AD	then msgleni =	-1	end
					if mtype ==	0x01AE	then msgleni =	4	end
					if mtype ==	0x01AF	then msgleni =	4	end
					if mtype ==	0x01B0	then msgleni =	11	end
					if mtype ==	0x01B2	then msgleni =	-1	end
					if mtype ==	0x01B3	then msgleni =	67	end
					if mtype ==	0x01B4	then msgleni =	12	end
					if mtype ==	0x01B5	then msgleni =	18	end
					if mtype ==	0x01B7	then msgleni =	6	end
					if mtype ==	0x01B8	then msgleni =	3	end
					if mtype ==	0x01B9	then msgleni =	6	end
					if mtype ==	0x01BA	then msgleni =	26	end
					if mtype ==	0x01BB	then msgleni =	26	end
					if mtype ==	0x01BC	then msgleni =	26	end
					if mtype ==	0x01BD	then msgleni =	26	end
					if mtype ==	0x01BE	then msgleni =	2	end
					if mtype ==	0x01BF	then msgleni =	3	end
					if mtype ==	0x01C0	then msgleni =	2	end
					if mtype ==	0x01C1	then msgleni =	14	end
					if mtype ==	0x01C2	then msgleni =	10	end
					if mtype ==	0x01C3	then msgleni =	-1	end
					if mtype ==	0x01C4	then msgleni =	22	end
					if mtype ==	0x01C5	then msgleni =	22	end
					if mtype ==	0x01C6	then msgleni =	4	end
					if mtype ==	0x01C7	then msgleni =	2	end
					if mtype ==	0x01C9	then msgleni =	97	end
					if mtype ==	0x01CB	then msgleni =	9	end
					if mtype ==	0x01CC	then msgleni =	9	end
					if mtype ==	0x01CD	then msgleni =	29	end
					if mtype ==	0x01CE	then msgleni =	6	end
					if mtype ==	0x01CF	then msgleni =	28	end
					if mtype ==	0x01D0	then msgleni =	8	end
					if mtype ==	0x01D1	then msgleni =	14	end
					if mtype ==	0x01D2	then msgleni =	10	end
					if mtype ==	0x01D3	then msgleni =	35	end
					if mtype ==	0x01D6	then msgleni =	4	end
					if mtype ==	0x01DB	then msgleni =	2	end
					if mtype ==	0x01DC	then msgleni =	-1	end
					if mtype ==	0x01DD	then msgleni =	47	end
					if mtype ==	0x01DF	then msgleni =	6	end
					if mtype ==	0x01E0	then msgleni =	30	end
					if mtype ==	0x01E1	then msgleni =	8	end
					if mtype ==	0x01E2	then msgleni =	34	end
					if mtype ==	0x01E3	then msgleni =	14	end
					if mtype ==	0x01E4	then msgleni =	2	end
					if mtype ==	0x01E5	then msgleni =	6	end
					if mtype ==	0x01E6	then msgleni =	26	end
					if mtype ==	0x01E7	then msgleni =	2	end
					if mtype ==	0x01E8	then msgleni =	28	end
					if mtype ==	0x01E9	then msgleni =	81	end
					if mtype ==	0x01EA	then msgleni =	6	end
					if mtype ==	0x01EB	then msgleni =	10	end
					if mtype ==	0x01EC	then msgleni =	26	end
					if mtype ==	0x01ED	then msgleni =	2	end
					if mtype ==	0x01EF	then msgleni =	-1	end
					if mtype ==	0x01F1	then msgleni =	-1	end
					if mtype ==	0x01F2	then msgleni =	20	end
					if mtype ==	0x01F3	then msgleni =	10	end
					if mtype ==	0x01F4	then msgleni =	32	end
					if mtype ==	0x01F5	then msgleni =	9	end
					if mtype ==	0x01F6	then msgleni =	34	end
					if mtype ==	0x01F7	then msgleni =	14	end
					if mtype ==	0x01F8	then msgleni =	2	end
					if mtype ==	0x01F9	then msgleni =	6	end
					if mtype ==	0x01FA	then msgleni =	48	end
					if mtype ==	0x01FB	then msgleni =	56	end
					if mtype ==	0x01FC	then msgleni =	-1	end
					if mtype ==	0x01FD	then msgleni =	4	end
					if mtype ==	0x01FE	then msgleni =	5	end
					if mtype ==	0x01FF	then msgleni =	10	end
					if mtype ==	0x0200	then msgleni =	26	end
					if mtype ==	0x0204	then msgleni =	18	end
					if mtype ==	0x020B	then msgleni =	19	end
					if mtype ==	0x2709	then msgleni =	2	end
					if mtype ==	0x2711	then msgleni =	3	end
					if mtype ==	0x2712	then msgleni =	19	end
					if mtype ==	0x2713	then msgleni =	51	end
					if mtype ==	0x2714	then msgleni =	6	end
					if mtype ==	0x2716	then msgleni =	6	end
					if mtype ==	0x2717	then msgleni =	50	end
					if mtype ==	0x2722	then msgleni =	86	end
					if mtype ==	0x2723	then msgleni =	7	end
					if mtype ==	0x2724	then msgleni =	10	end
					if mtype ==	0x2727	then msgleni =	6	end
					if mtype ==	0x2731	then msgleni =	11	end
					if mtype ==	0x2740	then msgleni =	54	end
					if mtype ==	0x2741	then msgleni =	7	end
					
					--ucitavanje i ispis drugih paketa unutar segmenta
					subtree:add_le(msg_type,buffer(iskoristeni_dio,2)):append_text(mtype_str)
					subtree:add_le("Deklarirana veličina: ", msgleni)
					velicina_ostalog_tereta=velicina_ostalog_tereta-msgleni
					subtree:add_le("Velicina ostalog tereta: ", velicina_ostalog_tereta)
				end
				
		end

end


--spajanje na tcp port
local tcp_port = DissectorTable.get("tcp.port")
tcp_port:add(47712,mana_protocol)

--skripta se pokrece naredbom wireshark -X lua_script:mana_dissector.lua
--skripta mora biti spremljena u direktorij u kojem je instaliran wireshark, npr. E:\Program Files\Wireshark