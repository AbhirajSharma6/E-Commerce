package com.ecommerce.dao;

import java.util.List;

/**
 * Generic DAO interface using Java Generics.
 * Provides a standard CRUD contract for all data access objects.
 *
 * @param <T> the entity type this DAO manages
 */
public interface GenericDAO<T> {

    /**
     * Retrieve an entity by its primary key.
     * @param id the primary key
     * @return the entity, or null if not found
     */
    T findById(int id) throws Exception;

    /**
     * Retrieve all entities.
     * @return list of all entities
     */
    List<T> findAll() throws Exception;

    /**
     * Insert a new entity into the database.
     * @param entity the entity to insert
     * @return true if insertion was successful
     */
    boolean insert(T entity) throws Exception;

    /**
     * Update an existing entity in the database.
     * @param entity the entity with updated fields
     * @return true if update was successful
     */
    boolean update(T entity) throws Exception;

    /**
     * Delete an entity by its primary key.
     * @param id the primary key of the entity to delete
     * @return true if deletion was successful
     */
    boolean delete(int id) throws Exception;
}
