using System;
using System.Collections.Generic;
using System.Text;
using MediatR;

namespace BarberFlow.Application.AuthItems.Login;

public class LoginCommandHandler : IRequestHandler<LoginCommand, string>
{
    var user = await _userRepository.GetFullUserByCpf(loginDTO.Cpf);

            if (user is null)
            {
                _logger.LogWarning("Login failed for CPF {Cpf}: user not found", loginDTO.Cpf);
                throw new UnauthorizedAccessException("Invalid CPF or Password!");
            }
            
            if (!SecurityUtils.VerifyPassword(loginDTO.Password, user.PasswordHash, user.PasswordSalt))
            {
                _logger.LogWarning("Login failed for CPF {Cpf}: incorrect password", loginDTO.Cpf);
                throw new UnauthorizedAccessException("Invalid CPF or Password!");
            }

            if (!user.IsActive)
{
    _logger.LogWarning("Login failed for CPF {Cpf}: user inactive", loginDTO.Cpf);
    throw new UnauthorizedAccessException("User is inactive!");
}
}
