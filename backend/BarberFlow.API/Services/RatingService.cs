using BarberFlow.API.Models.Rating;
using BarberFlow.API.Repositories.Rating;
using Microsoft.AspNetCore.Mvc;

namespace BarberFlow.API.Services;

public class RatingService(IRatingRepository ratingRepository)
{
    private readonly IRatingRepository _ratingRepository = ratingRepository;

    public async Task<IActionResult> GetRatings()
    {
        var result = await _ratingRepository.GetRatingsAsync();
        return new OkObjectResult(result);
    }

    public async Task<IActionResult> CreateRatingAsync(CreateRatingDTO createRatingDTO)
    {
        var createdRating = new RatingModel
        {
            UserId = createRatingDTO.UserId,
            Stars = createRatingDTO.Stars,
            Comment = createRatingDTO.Comment,
        };

        var result = await _ratingRepository.CreateAsync(createdRating);

        return new OkObjectResult(result);
    }

    public async Task<IActionResult> DeleteRatingAsync(int id, int parsedUserId)
    {
        var rating = await _ratingRepository.GetRatingByIdAsync(parsedUserId);

        if (rating is null)
            return new NotFoundObjectResult(new 
            { 
                error = "Avaliação não encontrada."
            });

        var result = await _ratingRepository.DeleteAsync(id);
        if (result)
            return new NoContentResult();
        
        return new NotFoundResult();
    }
}
