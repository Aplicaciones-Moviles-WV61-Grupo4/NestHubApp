package com.example.nesthub.feat_auth.domain.use_case

import com.example.nesthub.core.Resource
import com.example.nesthub.feat_auth.data.remote.dto.UserDto
import com.example.nesthub.feat_auth.data.remote.dto.toUser
import com.example.nesthub.feat_auth.domain.model.User
import com.example.nesthub.feat_auth.domain.repository.LoginRepository

class SignInUseCase (private val loginRepository: LoginRepository) {

    operator fun invoke(username: String, password: String, callback: (Resource<User>) -> Unit) {
        callback(Resource.Loading())
        loginRepository.signIn(username, password) { usersDto: List<UserDto> ->
            if (usersDto.isNotEmpty()) {
                callback(Resource.Success(data = usersDto[0].toUser()))
            } else {
                callback(Resource.Error(message = "An error occurred"))
            }
        }
    }

}