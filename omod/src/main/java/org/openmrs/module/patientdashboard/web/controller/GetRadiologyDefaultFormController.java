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

@Controller("GetRadiologyDefaultFormController")
@RequestMapping("/module/patientdashboard/getDefaultXRayFormm.form")
public class GetRadiologyDefaultFormController {

	@RequestMapping(method = RequestMethod.GET)
	public String getDefaultXRayForm(@RequestParam(value = "radiologyTestId") Integer testId,
			@RequestParam(value = "mode", required = false) String mode,
			Model model) {
		RadiologyService rs = (RadiologyService) Context.getService(RadiologyService.class);
		RadiologyTest test = rs.getRadiologyTestById(testId);
		Encounter encounter = test.getEncounter();
		RadiologyForm form = test.getForm();
		model.addAttribute("form", form);
		if (encounter != null)
			model.addAttribute("encounterId", encounter.getEncounterId());
		RadiologyUtil.generateDataFromEncounter(model, encounter, form);
		model.addAttribute("testId", testId);
		model.addAttribute("mode", mode);
		return "module/patientdashboard/getDefaultXRayForm";
	}
}
