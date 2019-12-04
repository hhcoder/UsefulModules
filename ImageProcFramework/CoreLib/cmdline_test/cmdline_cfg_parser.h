#ifndef _CMDLINE_CFG_PARSER_H_
#define _CMDLINE_CFG_PARSER_H_

#define CMDLINE_KEY_LEN				(256)
#define CMDLINE_VALUE_LEN			(256)
#define CMDLINE_TABLE_MAX			(256)

typedef struct _HashPair
{
	char key[CMDLINE_KEY_LEN];
	char value[CMDLINE_VALUE_LEN];
} HashPair;

typedef struct _ConfigParser
{
	HashPair table[CMDLINE_TABLE_MAX];
	size_t last_idx;
} ConfigParser;

ConfigParser* ConfigParserCreate(const char* ifname);

const char* ConfigParserGetProperty(ConfigParser* cfg, const char* key);

void ConfigParserDestroy(ConfigParser* cfg);

#endif //_CMDLINE_CFG_PARSER_H_