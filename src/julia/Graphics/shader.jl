type Shader
	ptr::Ptr{Void}

	function Shader(ptr::Ptr{Void})
		s = new(ptr)
		# finalizer(s, destroy)
		# s
	end
end

function Shader(vertex_shader::String, frag_shader::String)
	vert = isempty(vertex_shader) ? C_NULL : vertex_shader
	frag = isempty(frag_shader) ? C_NULL : frag_shader
	Shader(ccall((:sfShader_createFromFile, "libcsfml-graphics"), Ptr{Void}, (Ptr{Cchar}, Ptr{Cchar},), vert, frag))
end

function ShaderFromMemory(vertex_shader::String, frag_shader::String)
	vert = isempty(vertex_shader) ? C_NULL : vertex_shader
	frag = isempty(frag_shader) ? C_NULL : frag_shader
	Shader(ccall((:sfShader_createFromMemory, "libcsfml-graphics"), Ptr{Void}, (Ptr{Cchar}, Ptr{Cchar},), vert, frag))
end

function Shader(shader::String)
	shadername = basename(shader)
	if shadername[search(shadername, ".")+1] == "v"
		# This shader is a vertex shader
		Shader(shader, "")
	elseif shadername[search(shadername, ".") + 1] == "f"
		# This shader is a fragment shader
		Shader("", shader)
	else
		println("$shadername is not a valid shader file")
	end
end

function destroy(shader::Shader)
	ccall((:sfShader_destroy, "libcsfml-graphics"), Void, (Ptr{Void},), shader.ptr)
end

function set_parameter(shader::Shader, name::String, x::Real)
	ccall((:sfShader_setFloatParameter, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Cchar}, Cfloat,), shader.ptr, name, x)
end

function set_parameter(shader::Shader, name::String, x::Real, y::Real)
	ccall((:sfShader_setFloat2Parameter, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Cchar}, Cfloat, Cfloat,), shader.ptr, name, x, y)
end

function set_parameter(shader::Shader, name::String, x::Real, y::Real, z::Real)
	ccall((:sfShader_setFloat3Parameter, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Cchar}, Cfloat, Cfloat, Cfloat,), shaper.ptr, name, x, y, z)
end

function set_parameter(shader::Shader, name::String, x::Real, y::Real, z::Real, w::Real)
	ccall((:sfShader_setFloat4Parameter, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Cchar}, Cfloat, Cfloat, Cfloat, Cfloat), shaper.ptr, name, x, y, z, w)
end

function set_parameter(shader::Shader, name::String, vector::Vector2f)
	ccall((:sfShader_setVector2Parameter, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Cchar}, Vector2f,), shader.ptr, name, vector)
end

function set_parameter(shader::Shader, name::String, vector::Vector3f)
	ccall((:sfShader_setVector3Parameter, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Cchar}, Vector3f), shader.ptr, name, vector)
end

function set_parameter(shader::Shader, name::String, color::Color)
	ccall((:sfShader_setColorParameter, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Cchar}, Color), shader.ptr, name, color)
end

function set_parameter(shader::Shader, name::String, texture::Texture)
	ccall((:sfShader_setTextureParameter, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Cchar}, Ptr{Void},), shader.ptr, name, texture.ptr)
end

function set_parameter(shader::Shader, name::String)
	ccall((:sfShader_setCurrentTextureParameter, "libcsfml-graphics"), Void, (Ptr{Void}, Ptr{Cchar},), shader.ptr, name)
end

function bind(shader::Shader)
	ccall((:sfShader_bind, "libcsfml-graphics"), Void, (Ptr{Void},), shader.ptr)
end

function unbind()
	ccall((:sfShader_bind, "libcsfml-graphics"), Void, (Ptr{Void},), C_NULL)
end

function shader_is_available()
	Bool(ccall((:sfShader_isAvailable, "libcsfml-graphics"), Int32, ()))
end

export Shader, destroy, set_parameter, shader_is_available, ShaderFromMemory
