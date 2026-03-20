using System;
using System.Collections.Generic;
using System.Text;
using MediatR;
using Microsoft.Extensions.Logging;

namespace BarberFlow.Application.AuthItems.Login;

public class LoginCommandHandler(ILogger logger) : IRequestHandler<LoginCommand, string>
{
    private readonly ILogger _logger = logger;

    public async Task<Token> Handle(LoginCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Handling login command for Email {Email}", request.Email);
        await Helpers.ValidateUserCredentials(request.Email, request.Password);
        // Generate JWT token or similar authentication token here
        string token = ; // Placeholder for actual token generation logic
        _logger.LogInformation("Login successful for CPF {Cpf}", request.LoginDTO.Cpf);
        return token;
    }
}
