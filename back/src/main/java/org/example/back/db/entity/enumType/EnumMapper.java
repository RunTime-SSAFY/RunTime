package org.example.back.db.entity.enumType;

import lombok.NoArgsConstructor;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@NoArgsConstructor
public class EnumMapper {
    private Map<String, List<EnumMapperValue>> factory = new LinkedHashMap<>();

    public void put(String key, Class<? extends EnumMapperType> e) {
        factory.put(key, toEnumValues(e));
    }

    private List<EnumMapperValue> toEnumValues(Class<? extends EnumMapperType> e) {
        return Arrays.stream(e.getEnumConstants())
                .map(EnumMapperValue::new)
                .collect(Collectors.toList());
    }

    public List<EnumMapperValue> get(String key) {
        return factory.get(key);
    }

    public Map<String, List<EnumMapperValue>> get(List<String> keys) {
        if(keys == null || keys.size() == 0) {
            return new LinkedHashMap<>();
        }

        return keys.stream()
                .collect(Collectors.toMap(Function.identity(), key -> factory.get(key)));
    }

    public Map<String, List<EnumMapperValue>> getAll() { return factory; }
}
