package com.cragardev.plantkeeper.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;




@Entity
@Table(name="plants")
public class Plant {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@NotNull
	@Size(min=3, message="===  Plant name must be at least 3 characters.  ===")
	private String plantName;
	
	@NotNull
	// This will be a drop-down and the first one is preselected, so no need for validation other than not null
	private String waterSchedule;
	
	
	@NotNull
	@Size(min=10, message="===  Description must be at least 10 characters.  ===")
	private String description;
	

	// CreatedAt and UpdatedAt
	// This will not allow the createdAt column to be updated after creation
	@Column(updatable = false)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdAt;
	
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedAt;
	
	// Relationships connections
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;

	
	// Constructors
	
	// blank constructor
	
	public Plant() {
		super();
	}
	
	
	
	
	// full constructor
	public Plant(Long id,
			@NotNull @Size(min = 3, message = "===  Plant name must be at least 3 characters.  ===") String plantName,
			@NotNull String waterSchedule,
			@NotNull @Size(min = 10, message = "===  Description must be at least 10 characters.  ===") String description,
			Date createdAt, Date updatedAt, User user) {
		super();
		this.id = id;
		this.plantName = plantName;
		this.waterSchedule = waterSchedule;
		this.description = description;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		this.user = user;
	}



	
	
	// Simple constructor

	public Plant(
			@NotNull @Size(min = 3, message = "===  Plant name must be at least 3 characters.  ===") String plantName,
			@NotNull String waterSchedule,
			@NotNull @Size(min = 10, message = "===  Description must be at least 10 characters.  ===") String description,
			User user) {
		super();
		this.plantName = plantName;
		this.waterSchedule = waterSchedule;
		this.description = description;
		this.user = user;
	}



	// Getters and Setters
	
	

	public Long getId() {
		return id;
	}




	public void setId(Long id) {
		this.id = id;
	}




	public String getPlantName() {
		return plantName;
	}




	public void setPlantName(String plantName) {
		this.plantName = plantName;
	}




	public String getWaterSchedule() {
		return waterSchedule;
	}




	public void setWaterSchedule(String waterSchedule) {
		this.waterSchedule = waterSchedule;
	}




	public String getDescription() {
		return description;
	}




	public void setDescription(String description) {
		this.description = description;
	}




	public Date getCreatedAt() {
		return createdAt;
	}




	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}




	public Date getUpdatedAt() {
		return updatedAt;
	}




	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}




	public User getUser() {
		return user;
	}




	public void setUser(User user) {
		this.user = user;
	}




	// PrePersist and PreUpdate
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
	
}
