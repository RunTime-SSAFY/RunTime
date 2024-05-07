//package org.example.back.config;
//
//import jakarta.persistence.EntityManagerFactory;
//import lombok.RequiredArgsConstructor;
//import org.springframework.beans.factory.annotation.Qualifier;
//import org.springframework.boot.autoconfigure.orm.jpa.HibernateProperties;
//import org.springframework.boot.autoconfigure.orm.jpa.HibernateSettings;
//import org.springframework.boot.autoconfigure.orm.jpa.JpaProperties;
//import org.springframework.boot.context.properties.ConfigurationProperties;
//import org.springframework.boot.jdbc.DataSourceBuilder;
//import org.springframework.boot.orm.jpa.EntityManagerFactoryBuilder;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.context.annotation.Primary;
//import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
//import org.springframework.orm.jpa.JpaTransactionManager;
//import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
//import org.springframework.transaction.PlatformTransactionManager;
//import javax.sql.DataSource;
//import java.util.HashMap;
//import java.util.Map;
//
//@Configuration
//@EnableJpaRepositories(
//        basePackages = "org.example.back.db",
//        entityManagerFactoryRef = "db1EntityManagerFactory",
//        transactionManagerRef = "db1TransactionManager"
//)
//@RequiredArgsConstructor
//public class Db1Config {
//    private final JpaProperties jpaProperties;
//
//    private final HibernateProperties hibernateProperties;
//    @Primary
//    @Bean(name = "db1DataSource")
//    @ConfigurationProperties(prefix = "spring.datasource.db1")
//    public DataSource dataSource() {
//        return DataSourceBuilder.create().build();
//    }
//
//    @Primary
//    @Bean(name = "db1EntityManagerFactory")
//    public LocalContainerEntityManagerFactoryBean
//    entityManagerFactory(EntityManagerFactoryBuilder builder,
//                         @Qualifier("db1DataSource") DataSource dataSource) {
//        Map<String, Object> properties = hibernateProperties.determineHibernateProperties(jpaProperties.getProperties(), new HibernateSettings());
//
////        Map<String, Object> properties = new HashMap<>();
////        properties.put("hibernate.hbm2ddl.auto", "update"); // Enable ddl-auto for MySQL
////        properties.put("hibernate.format_sql", true); // Enable format_sql for MySQL
////        properties.put("hibernate.show_sql", true); // Enable show_sql for MySQL
////        properties.put("hibernate.naming.strategy", "org.hibernate.cfg.ImprovedNamingStrategy");
//
//        return builder
//                .dataSource(dataSource)
//                .packages("org.example.back.db")
//                .persistenceUnit("db1")
//                .properties(properties)
//                .build();
//    }
//
//    @Primary
//    @Bean(name = "db1TransactionManager")
//    public PlatformTransactionManager transactionManager(
//            @Qualifier("db1EntityManagerFactory") EntityManagerFactory entityManagerFactory) {
//        return new JpaTransactionManager(entityManagerFactory);
//    }
//}