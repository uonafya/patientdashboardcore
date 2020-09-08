/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 **/

package org.openmrs.module.patientdashboard.web.controller;

import org.openmrs.Encounter;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.RadiologyService;
import org.openmrs.module.hospitalcore.form.RadiologyForm;
import org.openmrs.module.hospitalcore.model.RadiologyTest;
import org.openmrs.module.hospitalcore.util.RadiologyUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("ShowRadiologyFormController")
@RequestMapping("/module/patientdashboard/showRadiologyForm.form")
public class ShowRadiologyFormController {

	/**
	 * Show form value
	 * 
	 * @param id
	 * @param mode
	 * @param encounterId
	 * @param radiologyTestId
	 * @param model
	 * @return
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String showForm(
			@RequestParam(value = "id", required = false) Integer id,
			@RequestParam(value = "mode", required = false) String mode,
			@RequestParam(value = "radiologyTestId", required = false) Integer radiologyTestId,
			Model model) {
		RadiologyService rs = (RadiologyService) Context
				.getService(RadiologyService.class);
		Encounter encounter = null;
		RadiologyForm form = null;

		if (radiologyTestId != null) {
			RadiologyTest test = rs.getRadiologyTestById(radiologyTestId);
			form = test.getForm();
			encounter = test.getEncounter();

			model.addAttribute("patientIdentifier", test.getPatient()
					.getPatientIdentifier().getIdentifier());
			model.addAttribute("orderId", test.getOrder().getOrderId());
		} else {
			if (id == 0) { // generate default form

				form = rs.getDefaultForm();
			} else { // get the existing form

				form = rs.getRadiologyFormById(id);
			}
		}

		model.addAttribute("form", form);
		model.addAttribute("mode", mode);
		if (encounter != null)
			model.addAttribute("encounterId", encounter.getEncounterId());

		RadiologyUtil.generateDataFromEncounter(model, encounter, form);
		return "/module/patientdashboard/show";
	}

}
