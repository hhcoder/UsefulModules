#include "../public/dpddm_tuning.h"

#include <map>
#include <string>

class DpddmTuningMap
{
public:
	DpddmTuningMap()
	{
		map_int.insert(std::pair<std::string, int32_t>("persist.vivo.camera.dpddm.integrate_len", 8));
	}

	uint32_t GetTuningValueFloat(const char* in_key, float* out_value)
	{
		std::map<std::string, float>::iterator iter = map_float.find(in_key);
		if (iter != map_float.end())
		{
			*out_value = iter->second;
			return DPDDM_TUNING_SEARCH_SUCCESS;
		}
		return DPDDM_TUNING_SEARCH_FAIL;
	}

	int32_t GetTuningValueInt(const char* in_key)
	{
		std::map<std::string, int32_t>::iterator iter = map_int.find(in_key);
		if (iter != map_int.end())
		{
			return iter->second;
		}
		else
		{
			throw "cannot find requested key";
		}
	}

private:
	std::map<std::string, float> map_float;
	std::map<std::string, int32_t> map_int;
};

static DpddmTuningMap pd1710_tuning;

int32_t DpddmTuningValueInt(const char* in_key)
{
	return pd1710_tuning.GetTuningValueInt(in_key);
}