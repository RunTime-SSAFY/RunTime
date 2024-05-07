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
//
//import javax.sql.DataSource;
//import java.util.Map;
//
//@Configuration
//@EnableJpaRepositories(
//        basePackages = "org.example.back.db2",
//        entityManagerFactoryRef = "db2EntityManagerFactory",
//        transactionManagerRef = "db2TransactionManager"
//)
//@RequiredArgsConstructor
//public class Db2Config {
//    private final JpaProperties jpaProperties;
//
//    private final HibernateProperties hibernateProperties;
//    @Bean(name = "db2DataSource")
//    @ConfigurationProperties(prefix = "spring.datasource.db2")
//    public DataSource dataSource() {
//        return DataSourceBuilder.create().build();
//    }
//
//    @Bean(name = "db2EntityManagerFactory")
//    public LocalContainerEntityManagerFactoryBean
//    entityManagerFactory(EntityManagerFactoryBuilder builder,
//                         @Qualifier("db2DataSource") DataSource dataSource) {
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
//                .packages("org.example.back.db2")
//                .persistenceUnit("db2")
//                .properties(properties)
//                .build();
//    }
//
//    @Bean(name = "db2TransactionManager")
//    public PlatformTransactionManager transactionManager(
//            @Qualifier("db2EntityManagerFactory") EntityManagerFactory entityManagerFactory) {
//        return new JpaTransactionManager(entityManagerFactory);
//    }
//}
