package com.cragardev.plantkeeper.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.cragardev.plantkeeper.models.Plant;
import com.cragardev.plantkeeper.repositories.PlantRepository;

@Service
public class PlantService {
	
	// Inject Plant Repo
	
	public final PlantRepository plantRepo;
	
	public PlantService(PlantRepository plantRepo) {
		this.plantRepo = plantRepo;
	}
	
	//
	// Find All Plants
	//
	public List<Plant> allPlants() {
		return plantRepo.findAll();
	}
	
	//
	// Create Plant
	//
	public Plant createPlant(Plant plant) {
		return plantRepo.save(plant);
		
	}
	
	
	//
	// Find One Plant
	//
	public Plant findPlant(Long id) {
		Optional<Plant> optionalPlant = plantRepo.findById(id);
		if(optionalPlant.isPresent()) {
			return optionalPlant.get();
		} else {
			return null;
		}
	}
	
	
	//
	// Update Plant
	//
	public Plant updatePlant(Plant plant) {
		return plantRepo.save(plant);
		
	}
	
	
	//
	// Delete Plant
	//
	public void deletePlant(Long id) {
		plantRepo.deleteById(id);
		
	}
	
	
	
}
