#pragma once

#include "../common/dpd_frame.h"

#include <iostream>
#include <fstream>

template <typename T>
class BasePyramid
{
private:
	inline int32_t IncreaseToEven(const int32_t a) { return a + a % 2; }
	inline int32_t DecreaseToEven(const int32_t a) { return a - a % 2; }
	int32_t DimShrink(const int32_t a, const int32_t shrink_size)
	{
		float a_f = static_cast<float>(a);
		float s_f = static_cast<float>(shrink_size);
		float ratio = a_f / s_f;
		float v = std::ceil(ratio);

		return static_cast<int32_t>(v);
	}

public:
	BasePyramid(const size_t in_level, const DimWH& in_dim, const T& in_init)
		: frame_vector(in_level), 
		//TODO: from tuning
		shrink_size(2)
	{
		int32_t w = in_dim.first;
		int32_t h = in_dim.second;

		for (size_t i = 0; i < in_level; i++)
		{
			frame_vector[i] = new BaseFrame<T>(DimWH(w, h), in_init);

			w = DimShrink(w, shrink_size);
			h = DimShrink(h, shrink_size);
		}
	}

	~BasePyramid()
	{
		for (std::vector<BaseFrame<T>*>::iterator i = frame_vector.begin(); i!=frame_vector.end(); i++)
		{
			delete *i;
		}
	}

	static int32_t CalcBaseLength(const int32_t top_length, const size_t num_levels)
	{
		//TODO: 2.0f from tuning?
		const float ratio = std::powf(2.0f, static_cast<float>(num_levels - 1));
		const int32_t base_length = static_cast<int32_t>(std::ceil(top_length * ratio));

		return base_length;
	}

	//TODO: Consider return &
	BaseFrame<T>* GetFrame(const size_t level) { return frame_vector[level]; }
	const BaseFrame<T>* GetFrame(const size_t level) const { return frame_vector[level]; }

	T* GetElem(const size_t level, const int32_t x, const int32_t y)
	{
		if (x >= Width(level) || y >= Height(level))
		{
			std::cout << "Get: out of boundary " << " level: " << level << " x: " << x << " y: " << y << std::endl;
			return NULL;
		}

		return frame_vector[level]->GetElem(x, y);
	}

	T* GetElem(const size_t level, const int32_t x, const int32_t y) const
	{
		if (x >= Width(level) || y >= Height(level))
		{
			std::cout << "Get: out of boundary " << " level: " << level << " x: " << x << " y: " << y << std::endl;
			return NULL;
		}

		return frame_vector[level]->GetElem(x, y);
	}

	void Set(const size_t level, const int32_t x, const int32_t y, const T& in_val)
	{
		if (x >= Width(level) || y >= Height(level))
		{
			std::cout << "Set: out of boundary" << "level: " << level << "x: " << x << "y: " << y << std::endl;
			return;
		}

		frame_vector[level]->SetElem(x, y, in_val);
	}

	int32_t Width(const size_t level) const { return frame_vector[level]->Width(); }
	int32_t Height(const size_t level) const { return frame_vector[level]->Height(); }
	size_t NumLevels() const { return frame_vector.size(); }
	size_t TopLevel() const { return frame_vector.size() - 1; }
	size_t BottomLevel() const { return 0; }

	void WriteTxt(const char* fname, const size_t level)
	{
		const Layer* l = GetFrame(level);

		l->WriteTxt(fname);
	}

	void WriteTxt(const char* folder, const char* common_fname, const char* extension)
	{
		for (size_t i = 0; i < NumLevels(); i++)
		{
			char out_fname[256];
			sprintf(out_fname, "%s%s_%d%s", "../../ProcessedResults/tmp/", "pd_pyramid", i, ".txt");
			WriteTxt(out_fname, i);
		}
	}

	void DumpInfo(const std::string& folder, const std::string& name) const
	{
		const std::string func_prefix("Func_");
		const std::string m_extension(".m");
		const std::string mkey_function("function ");

		std::string master_name = name + std::string("_master");
		std::string master_path = folder + func_prefix + master_name + m_extension;

		std::fstream master_file(master_path, std::fstream::out);

		master_file << mkey_function << "[" << master_name << ", h_img, h_surf] = " << func_prefix << master_name << std::endl;

		master_file << name << "_master = cell(" << NumLevels() << ",1);" << std::endl;

		for (size_t i = 0; i < NumLevels(); i++)
		{
			const std::string num = std::to_string(i);
			const std::string var_name = name + num;
			const std::string var_path = folder + func_prefix + var_name + m_extension;

			const Layer* l = GetFrame(i);
			std::fstream var_file(var_path, std::fstream::out);

			l->DumpInfo(var_name);

			master_file << var_name << "=" << func_prefix << var_name << "();" << std::endl;
			master_file << name << "_master{" << i+1 << "}=" << var_name << ";" << std::endl;
		}

		master_file << "end" << std::endl;
	}

	typedef BaseFrame<T> Layer;

private:
	std::vector<BaseFrame<T>*> frame_vector;
	int32_t shrink_size;
};

