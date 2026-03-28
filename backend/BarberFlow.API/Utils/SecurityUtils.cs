using BarberFlow.API.Models;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace BarberFlow.API.Utils;

public class SecurityUtils
{
    public static string CreatePasswordHash(string password)
    {
        return BCrypt.Net.BCrypt.HashPassword(password);
    }

    public static string GenerateJwtToken(UserModel user, IConfiguration _configuration)
    {
        var key = Encoding.ASCII.GetBytes(_configuration["Jwt:Key"]!);

        var claims = new[]
        {
            new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
            new Claim(ClaimTypes.Name, user.Name),
            new Claim(ClaimTypes.Role, user.Role)
        };

        var tokenDescriptor = new SecurityTokenDescriptor
        {
            Subject = new ClaimsIdentity(claims),
            Expires = DateTime.UtcNow.AddMinutes(int.Parse(_configuration["Jwt:ExpireMinutes"]!)),
            Issuer = _configuration["Jwt:Issuer"],
            Audience = _configuration["Jwt:Audience"],
            SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha512Signature)
        };

        var tokenHandler = new JwtSecurityTokenHandler();
        var token = tokenHandler.CreateToken(tokenDescriptor);
        return tokenHandler.WriteToken(token);
    }

    public static bool VerifyPassword(string password, string storedHash)
    {
        return BCrypt.Net.BCrypt.Verify(password, storedHash);
    }

    public static void ValidatePasswordStrength(string password)
    {
        var errors = new List<string>();

        if (string.IsNullOrWhiteSpace(password))
            errors.Add("Senha não pode ser vazia.");

        if (password.Length < 8)
            errors.Add("Senha deve ser maior que 8 caracteres.");

        if (!password.Any(char.IsUpper))
            errors.Add("Senha deve conter pelo menos 1 letra maiúscula.");

        if (!password.Any(char.IsLower))
            errors.Add("Senha deve conter pelo menos 1 letra minúscula.");

        if (!password.Any(char.IsDigit))
            errors.Add("Senha deve conter pelo menos 1 número.");

        if (!password.Any(ch => "!@#$%^&*()_+-=[]{}|;:,.<>?".Contains(ch)))
            errors.Add("Senha deve conter pelo menos 1 caracter especial.");

        if (errors.Count != 0)
            throw new ArgumentException(string.Join(" ", errors));
    }
}
