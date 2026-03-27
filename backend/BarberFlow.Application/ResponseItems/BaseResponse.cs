using System;
using System.Collections.Generic;
using System.Text;
using System.Text.Json.Serialization;

namespace BarberFlow.Application.ResponseItems;

public sealed class BaseResponse<T>
{
    public bool Success { get; init; }

    public int StatusCode { get; init; }

    [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
    public T? Data { get; init; } = default;

    [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
    public int? ObjectId { get; init; } = default;

    [JsonIgnore(Condition = JsonIgnoreCondition.WhenWritingNull)]
    public string? ErrorMessage { get; init; } = default;

    public static BaseResponse<T> SuccessResponse(T? data, int? objectId = null)
        => new()
        {
            Success = true,
            StatusCode = 200,
            Data = data,
            ObjectId = objectId
        };

    public static BaseResponse<T> ErrorResponse(int statusCode, string errorMessage)
        => new()
        {
            Success = false,
            StatusCode = statusCode,
            ErrorMessage = errorMessage
        };
}
