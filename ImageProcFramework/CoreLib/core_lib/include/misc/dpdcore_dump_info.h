#pragma once

#include <string>
#include <fstream>
#include <vector>

class DpdInfoDump
{
public:

	static void Enable() { DebugModeEnabled = true; }
	static void Disable() { DebugModeEnabled = false; }
	static bool Status() { return DebugModeEnabled;  }

private:
	static bool DebugModeEnabled;

public:
	DpdInfoDump(const std::string& var_name)
		: func_prefix("Func_"),
		  m_extension(".m"),
		  mkey_function("function "),
		  var_path(OutputDirectory() + func_prefix + var_name + m_extension),
		  file_out(var_path, std::fstream::out)
	{
		file_out << mkey_function << var_name << " = " << func_prefix << var_name << std::endl;

		file_out << var_name << ".name" << "=" << "\'" << var_name << "\'" << ";" << std::endl;
		file_out << var_name << ".value" << "=" << "..." << std::endl;
		file_out << "[";
	}

	~DpdInfoDump()
	{
		file_out << std::endl << "];" << std::endl << "end" << std::endl;
	}

	void ChangeLine()
	{
		file_out << std::endl;
	}

	typedef DpdInfoDump& (*MyStreamManipulator)(DpdInfoDump&);

	DpdInfoDump& operator<<(DpdInfoDump::MyStreamManipulator manip)
	{
		return manip(*this);
	}

	DpdInfoDump& operator<<(const std::string& in_str)
	{
		file_out << in_str;
		return *this;
	}

	DpdInfoDump& operator<<(const char* in_cstr)
	{
		file_out << in_cstr;
		return *this;
	}

	DpdInfoDump& operator<<(const int32_t v)
	{
		file_out << v;
		return *this;
	}

	DpdInfoDump& operator<<(const float v)
	{
		file_out << v;
		return *this;
	}

	DpdInfoDump& operator<<(const uint32_t v)
	{
		file_out << v;
		return *this;
	}

	DpdInfoDump& operator<<(const std::vector<uint32_t>& vect)
	{
		for (std::vector<uint32_t>::const_iterator i = vect.begin();
			i != vect.end();
			i++)
			file_out << *i << ",";

		return *this;
	}

	static DpdInfoDump& endl(DpdInfoDump& stream)
	{
		stream.ChangeLine();

		return stream;
	}

private:
	const std::string OutputDirectory()
	{
		return std::string("../../ProcessedResults/tmp/");
	}

protected:
	std::string func_prefix;
	std::string m_extension;
	std::string mkey_function;
	std::string var_path;
	std::fstream file_out;
};

class DpdInfoDumpBase
{
public:
	DpdInfoDumpBase()
	{
	}

	virtual ~DpdInfoDumpBase() {}

	void DumpInfo(const std::string& var_name) const
	{
		if (!DpdInfoDump::Status())
			return;

		DpdInfoDump dout(var_name);

		DumpInfoImpl(dout);
	}

protected:
	virtual void DumpInfoImpl(DpdInfoDump& dout) const = 0;
};
