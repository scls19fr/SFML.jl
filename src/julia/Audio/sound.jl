type Sound
	ptr::Ptr{Void}
end

function Sound()
	return Sound(ccall(dlsym(libcsfml_audio, :sfSound_create), Ptr{Void}, ()))
end

function copy(sound::Sound)
	return Sound(ccall(dlsym(libcsfml_audio, :sfSound_copy), Ptr{Void}, (Ptr{Void},), sound.ptr))
end

function destroy(sound::Sound)
	ccall(dlsym(libcsfml_audio, :sfSound_destroy), Void, (Ptr{Void},), sound.ptr)
	sound = nothing
end

function play(sound::Sound)
	ccall(dlsym(libcsfml_audio, :sfSound_play), Void, (Ptr{Void},), sound.ptr)
end

function pause(sound::Sound)
	ccall(dlsym(libcsfml_audio, :sfSound_pause), Void, (Ptr{Void},), sound.ptr)
end

function stop(sound::Sound)
	ccall(dlsym(libcsfml_audio, :sfSound_stop), Void, (Ptr{Void},), sound.ptr)
end

function set_buffer(sound::Sound, sound_buffer::SoundBuffer)
	ccall(dlsym(libcsfml_audio, :sfSound_setBuffer), Void, (Ptr{Void}, Ptr{Void},), sound.ptr, sound_buffer.ptr)
end

function get_buffer(sound::Sound)
	return SoundBuffer(ccall(dlsym(libcsfml_audio, :sfSound_getBuffer), Void, (Ptr{Void},), sound.ptr))
end

function set_loop(sound::Sound, loop::Bool)
	ccall(dlsym(libcsfml_audio, :sfSound_setLoop), Void, (Ptr{Void}, Int32,), sound.ptr, loop)
end

function get_loop(sound::Sound)
	return Bool(ccall(dlsym(libcsfml_audio, :sfSound_getLoop), Int32, (Ptr{Void},), sound.ptr))
end

function set_pitch(sound::Sound, pitch::Real)
	ccall(dlsym(libcsfml_audio, :sfSound_setPitch), Void, (Ptr{Void}, Cfloat,), sound.ptr, pitch)
end

function set_volume(sound::Sound, volume::Real)
	ccall(dlsym(libcsfml_audio, :sfSound_setVolume), Void, (Ptr{Void}, Cfloat,), sound.ptr, volume)
end

export Sound, copy, desoytr, play, pause, stop, set_buffer, set_loop, get_loop, set_pitch, set_volume