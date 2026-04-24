using System.Security.Claims;
using BarberFlow.API.Models.Rating;
using BarberFlow.API.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BarberFlow.API.Controllers;

[ApiController]
[Route("barber/rating")]
public class RatingController(RatingService ratingService) : ControllerBase
{
    private readonly RatingService _ratingService = ratingService;

    [HttpGet]
    [Authorize]
    public async Task<IActionResult> GetRatings()
    {
        var result = await _ratingService.GetRatings();
        return result;
    }

    [HttpPost]
    [Authorize]
    public async Task<IActionResult> CreateRating(CreateRatingDTO createRatingDTO)
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        createRatingDTO.UserId = int.Parse(userId!);

        var rating = await _ratingService.CreateRatingAsync(createRatingDTO);
        return rating;
    }

    [HttpDelete("{id}")]
    [Authorize]
    public async Task<IActionResult> DeleteRating(int id)
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var parsedUserId = int.Parse(userId!);

        var result = await _ratingService.DeleteRatingAsync(id, parsedUserId);

        return result;
    }
}
