#ifndef _COBJ_WRAPPER_H_
#define _COBJ_WRAPPER_H_

#include <stdint.h>

template<typename T> 
	class CObjectWrapper
{
public:
	static void* Create()
	{
		CObjectWrapper* cobj = new CObjectWrapper();
		cobj->reference_id = CObjectWrapper::obj_reference_id;
		return static_cast<void*>(cobj);
	}

	static bool Destroy(void* cobj)
	{
		if (NULL == GetImpl(cobj))
			return false;

		CObjectWrapper* p_wrapper = static_cast<CObjectWrapper*>(cobj);
		delete p_wrapper;

		return true;
	}

	static T* GetImpl(void* cobj)
	{
		if (NULL == cobj)
			return NULL;

		CObjectWrapper* obj = (CObjectWrapper*)cobj;
		if (obj->reference_id != obj_reference_id)
			return NULL;

		return obj->impl;
	}

private:
	CObjectWrapper()
		: impl(new T)
	{	
		//TODO: exception handle
	}

	~CObjectWrapper()
	{
		delete impl;
	}

public:
	static uint32_t obj_reference_id;

private:
	uint32_t reference_id;
	T* impl;
};


#endif //_COBJ_WRAPPER_H_
