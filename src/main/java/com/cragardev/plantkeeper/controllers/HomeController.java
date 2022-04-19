package com.cragardev.plantkeeper.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cragardev.plantkeeper.models.LoginUser;
import com.cragardev.plantkeeper.models.Plant;
import com.cragardev.plantkeeper.models.User;
import com.cragardev.plantkeeper.services.PlantService;
import com.cragardev.plantkeeper.services.UserService;

@Controller
public class HomeController {

	//
	// Inject the Services
	//
	private final UserService userService;
	private final PlantService plantService;

	//
	// Services Constructors
	//

	public HomeController(UserService userService, PlantService plantService) {
		super();
		this.userService = userService;
		this.plantService = plantService;
	}

	//
	// ========= /, Landing, home, index page 1 ===========
	//
	@GetMapping("/")
	public String index() {

		return "index.jsp";
	}

	//
	// ========= /, Landing, home, index page 2 ===========
	//
	@GetMapping("/home")
	public String home() {

		return "index.jsp";
	}

	//
	// ========= /, Dashboard page ===========
	// Show all plants and all users
	//
	@GetMapping("/dashboard")
	public String dashboard(
			Model model,
			HttpSession session,
			RedirectAttributes redirectAttributes) {

		// check to see if user is logged in

		if (session.getAttribute("user_id") == null) {
			// if not in session, redirect to login
			return "redirect:/createError";
		}

		// Get users info to show them logged in
		model.addAttribute("user", userService.findUser((Long)session.getAttribute("user_id")));

		// Send all the plants to the JSP using Model model
		model.addAttribute("plants", plantService.allPlants());

		// Send all our users to the JSP using Model model
		model.addAttribute("users", userService.allUsers());

		return "dashboard.jsp";
	}

	// this was to test with
	// //
	// // ========= /, Login/Registration page ===========
	// //
	// @GetMapping("/login")
	// public String login() {
	//
	// return "login.jsp";
	// }

	//
	// ========= One Plant Details page ===========
	//
	@GetMapping("/onePlantDetails/{id}")
	public String onePlantDetails(
			Model model,
			@PathVariable(value = "id") Long id,
			HttpSession session) {

		// check to see if user is logged in
		if (session.getAttribute("user_id") == null) {
			// if not in session, redirect to login
			return "redirect:/createError";
		}

		// send Plant to JSP
		Plant plant = plantService.findPlant(id);
		model.addAttribute("plant", plant);
		
		// Get users info to show them logged in
		model.addAttribute("user", userService.findUser((Long)session.getAttribute("user_id")));


		return "onePlantDetails.jsp";
	}

	//
	// ========= One User Details page ===========
	//
	@GetMapping("/oneUserDetails/{id}")
	public String oneUserDetails(
			@PathVariable(value = "id") Long id,
			Model model,
			HttpSession session) {

		// check to see if user is logged in
		if (session.getAttribute("user_id") == null) {
			// if not in session, redirect to login
			return "redirect:/createError";
		}
		
		model.addAttribute("LoggedUser", userService.findUser((Long)session.getAttribute("user_id"))); 
		
		// send User to JSP
		User user = userService.findUser(id);
		model.addAttribute("user", user);

			
		return "oneUserDetails.jsp";
	}

	// ---------------------------------------- CREATE NEW -----------
	//
	// ========= Create One Plant page ===========
	//
	@GetMapping("/createNewPlant")
	public String createNewPlant(@ModelAttribute("plant") Plant plant,
			Model model,
			HttpSession session) {

		// check to see if user is logged in

		if (session.getAttribute("user_id") == null) {
			// if not in session, redirect to login
			return "redirect:/createError";
		}

		model.addAttribute("allUsers", userService.allUsers());
		Long user_id = (Long) session.getAttribute("user_id");
		User user = userService.findUser(user_id);
		model.addAttribute("user", user);

		return "createNewPlant.jsp";
	}

	//
	// ========= Create New PROCESS ===========
	//
	@PostMapping("/createNewPlant")
	public String createNewPlantProcess(
			@Valid @ModelAttribute("plant") Plant plant,
			BindingResult result,
			Model model) {

		if (result.hasErrors()) {
			model.addAttribute("plant", plant);
			model.addAttribute("allUsers", userService.allUsers());
			return "createNewPlant.jsp";
		} else {
			plantService.createPlant(plant);
			return "redirect:/dashboard";
		}
	}

	// ---------------------------------------- UPDATE -----------
	//
	// ========= Update Plant page ===========
	//
	@GetMapping("/updatePlant/{id}")
	public String updatePlant(
			@PathVariable("id") Long id,
			@ModelAttribute("plant") Plant plant,
			Model model, HttpSession session) {
		// check to see if user is logged in

		if (session.getAttribute("user_id") == null) {
			// if not in session, redirect to login
			return "redirect:/createError";
		}

		model.addAttribute("allUsers", userService.allUsers());

		model.addAttribute("plant", plantService.findPlant(id));

		return "updatePlant.jsp";
	}

	//
	// ========= Update PROCESS ===========
	//
	@RequestMapping(value = "/updatePlant/{id}", method = RequestMethod.PUT)
	public String updatePlantProcess(
			@Valid @ModelAttribute("plant") Plant plant,
			BindingResult result,
			Model model) {

		if (result.hasErrors()) {
			model.addAttribute("allUsers", userService.allUsers());
			return "updatePlant.jsp";
		} else {

			plantService.updatePlant(plant);
			return "redirect:/dashboard";
		}

	}

	//
	// ================== ERRORS ==========================
	//
	@RequestMapping("/createError")
	public String flashMessages(RedirectAttributes redirectAttributes) {
		redirectAttributes.addFlashAttribute("error", "Please log in or Register!");
		return "redirect:/login";
	}

	// ---------------------------------------- DELETE ----------
	//
	// ========= Delete PROCESS ===========
	//
	@GetMapping("/deletePlant/{id}") // add an Id
	public String deletePlant(@PathVariable("id") Long id) {

		plantService.deletePlant(id);

		return "redirect:/dashboard";
	}

	// **************************************************************************************************************
	//
	// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ LOGIN REGISTRATION
	// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	//
	// **************************************************************************************************************

	@GetMapping("/login")
	public String login(Model model, HttpSession session) {

		// Bind empty User and LoginUser objects to the JSP
		// to capture the form input
		session.invalidate();
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "login.jsp";
	}

	@PostMapping("/login")
	public String loginProcess(
			@Valid @ModelAttribute("newLogin") LoginUser newLogin,
			BindingResult result,
			Model model,
			HttpSession session) {

		// Add once service is implemented:
		// User user = userServ.login(newLogin, result);
		User user = userService.login(newLogin, result);

		if (result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "login.jsp";
		}

		// No errors!
		// TO-DO Later: Store their ID from the DB in session,
		// in other words, log them in.
		session.setAttribute("user_id", user.getId());

		return "redirect:/dashboard";
	}

	@PostMapping("/register")
	public String registerProcess(
			@Valid @ModelAttribute("newUser") User newUser,
			BindingResult result,
			Model model,
			HttpSession session) {

		// TO-DO Later -- call a register method in the service
		// to do some extra validations and create a new user!
		userService.register(newUser, result);

		if (result.hasErrors()) {
			// Be sure to send in the empty LoginUser before
			// re-rendering the page.
			model.addAttribute("newLogin", new LoginUser());
			return "login.jsp";
		}

		// No errors!
		// TO-DO Later: Store their ID from the DB in session,
		// in other words, log them in.

		session.setAttribute("user_id", newUser.getId());

		return "redirect:/dashboard";
	}

	// Log out user
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";

	}

	// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

}
