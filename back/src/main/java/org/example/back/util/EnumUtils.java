package org.example.back.util;

import org.example.back.exception.EnumBadRequestException;

import java.util.Optional;

public class EnumUtils {

    public static <T extends Enum<T>> T getIgnoreCase(Class<T> enumType, String value) {
        if (value == null) {
            return null;
        }

        for (T enumConstant : enumType.getEnumConstants()) {
            if (enumConstant.name().equalsIgnoreCase(value.trim())) {
                return enumConstant;
            }
        }
        return null;
    }

    public static <T extends Enum<T>> T getIgnoreCaseOrThrow(Class<T> enumType, String value) {
        T enumValue = getIgnoreCase(enumType, value);
        return Optional.ofNullable(enumValue)
                .orElseThrow(EnumBadRequestException::new);
    }
}
