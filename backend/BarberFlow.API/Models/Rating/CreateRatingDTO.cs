using System.Text.Json.Serialization;

namespace BarberFlow.API.Models.Rating;

public class CreateRatingDTO
{
    [JsonPropertyName("estrelas")]
    public int Stars { get; set; }
    
    [JsonPropertyName("comentario")]
    public string? Comment { get; set; }

    [JsonIgnore]
    public int UserId { get; set; }

    [JsonPropertyName("serviceId")]
    public int? ServiceId { get; set; }
}
