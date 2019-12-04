#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "./cmdline_cfg_parser.h"

#ifdef _ANDROID_
#define strcpy_s(_dest_, _dest_sz_, _src_) strcpy((_dest_), (_src_))
#endif

static void ConfigParserSetProperty(ConfigParser* cfg, const char* key, const char* value)
{
	if (cfg->last_idx<CMDLINE_TABLE_MAX)
	{
		strcpy_s(cfg->table[cfg->last_idx].key, CMDLINE_KEY_LEN, key);
		strcpy_s(cfg->table[cfg->last_idx].value, CMDLINE_VALUE_LEN, value);
		cfg->last_idx++;
	}
}

const char* ConfigParserGetProperty(ConfigParser* cfg, const char* key)
{
	for (size_t i = 0; i<cfg->last_idx; i++)
	{
		if (!strcmp(cfg->table[i].key, key))
		{
			return cfg->table[i].value;
		}
	}
	return NULL;
}

ConfigParser* ConfigParserCreate(const char* ifname)
{
	FILE* fp = fopen(ifname, "r");
	if (NULL == fp)
	{
		printf("Error opening config file: %s", ifname);
		return 0;
	}

	ConfigParser* cfg = (ConfigParser*)malloc(sizeof(ConfigParser));
	if (NULL == cfg)
		return cfg;

	cfg->last_idx = 0;
	memset(cfg->table, 0x00, sizeof(cfg->table));

	char key[CMDLINE_KEY_LEN];
	char value[CMDLINE_VALUE_LEN];

	int idx = 0;
	while (EOF != fscanf(fp, "%s", key) &&
		EOF != fscanf(fp, "%s", value) &&
		idx<CMDLINE_TABLE_MAX)
	{
		ConfigParserSetProperty(cfg, key, value);
		idx++;
	}

	fclose(fp);

	return cfg;
}

void ConfigParserDestroy(ConfigParser* cfg)
{
	if (NULL != cfg)
		free(cfg);
}