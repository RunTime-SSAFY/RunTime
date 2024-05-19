package org.example.back.auth.dto;


import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TestJoinResponseDto {
    private Long id;
    private String email;
    private String nickname;

    TokenResponseDto tokenResponseDto;
}
