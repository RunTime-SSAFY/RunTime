package org.example.back.redis.repository;

import org.example.back.redis.entity.BlackList;
import org.example.back.redis.entity.RefreshToken;
import org.springframework.data.repository.CrudRepository;

public interface BlackListRepository extends CrudRepository<BlackList, String> {
}
