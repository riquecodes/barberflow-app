using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace BarberFlow.API.Extensions;

public static class ClaimsPrincipalExtensions
{
    public static int GetUserId(this ClaimsPrincipal principal)
    {
        var claim = principal.FindFirst("user_id") ?? principal.FindFirst(JwtRegisteredClaimNames.Sub);
        if (claim is null || !int.TryParse(claim.Value, out var userId))
        {
            throw new InvalidOperationException("Não foi possível identificar o usuário autenticado.");
        }

        return userId;
    }
}
