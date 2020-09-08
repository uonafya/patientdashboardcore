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
 *
 **/

package org.openmrs.module.patientdashboard.web.controller;

import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.openmrs.Concept;
import org.openmrs.ConceptAnswer;
import org.openmrs.ConceptDatatype;
import org.openmrs.ConceptNumeric;
import org.openmrs.Encounter;
import org.openmrs.EncounterType;
import org.openmrs.Location;
import org.openmrs.Obs;
import org.openmrs.Patient;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.LabService;
import org.openmrs.module.hospitalcore.PatientDashboardService;
import org.openmrs.module.hospitalcore.model.Lab;
import org.openmrs.module.hospitalcore.util.PatientDashboardConstants;
import org.openmrs.module.patientdashboard.web.controller.global.Node;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("InvestigationReportController")
@RequestMapping("/module/patientdashboard/investigationReport.htm")
public class InvestigationReportController {
	

	@RequestMapping(method=RequestMethod.GET)
	public String firstView( @RequestParam("patientId") Integer patientId,@RequestParam(value="date", required=false) String date, Model model){
			PatientDashboardService dashboardService =  Context.getService(PatientDashboardService.class);
	        String orderLocationId = "1";
	        Location location = StringUtils.hasText(orderLocationId) ? Context.getLocationService().getLocation(Integer.parseInt(orderLocationId)) : null;
			LabService labService = Context.getService(LabService.class);
			// get all labs
			List<Lab> labs = labService.getAllActivelab();

			// get all test in system base on list labs
			Set<Concept> listParent = new HashSet<Concept>();
			if ( labs != null && !labs.isEmpty() ){
				for( Lab lab : labs ){
					 listParent.addAll(lab.getInvestigationsToDisplay());
				}
			}
			Set<Node> nodes = new TreeSet<Node>();
			
	        Patient patient = Context.getPatientService().getPatient(patientId);
	        
	        String gpLabEncType = Context.getAdministrationService().getGlobalProperty(PatientDashboardConstants.PROPERTY_LAB_ENCOUTNER_TYPE);
	        EncounterType labEncType = Context.getEncounterService().getEncounterType(gpLabEncType);
	        
			List<Encounter> encounters = dashboardService.getEncounter(patient, location, labEncType, date);
			
			//ghanshyam,date:25-april-2013 Feedback #1429 Wrong Result Generated in Laboratory record(below written LinkedHashSet at the place of HashSet)
			Set<String> dates = new LinkedHashSet<String>();
			if( encounters != null && encounters.size() > 0 )
			{
				Set<Obs> listObs = null;
				Concept obsConcept  = null;
				Concept orderConcept  = null;
				for( Encounter enc : encounters)
				{
					listObs = enc.getAllObs(false);
					if( listObs != null && !listObs.isEmpty() ){
						for( Obs obs : listObs ){
							// result 
							obsConcept = obs.getConcept();
							
							orderConcept = obs.getOrder().getConcept();
							
							if( orderConcept.getConceptClass().getName().equalsIgnoreCase("Test")){
								Node node = new Node(obsConcept.getConceptId(), obsConcept.getName().toString());
								addNode(node, nodes, obsConcept, listParent);
							}else if( orderConcept.getConceptClass().getName().equalsIgnoreCase("Labset")){
								Node node = new Node(obsConcept.getConceptId(), obsConcept.getName().toString());
								nodes = addNodeAndChild(nodes, orderConcept, node, null, listParent, false);
								
							}
							// add date
							dates.add(Context.getDateFormat().format(obs.getDateCreated()));
						}
					}
				}// end for encounter
			}
			model.addAttribute("nodes", nodes);
			model.addAttribute("dates",dates);
			model.addAttribute("patientId",patientId);
		
		return "module/patientdashboard/investigationReport";
	}
	
	@RequestMapping(method=RequestMethod.POST)
	public String formSubmit(InvestigationCommand investigationCommand , Model model){
		//ghanshyam 07-may-2013 Bug #1429 Feedback [Patient Dashboard] Wrong Result Generated in Laboratory record(note:added below line)
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
		try{
		// get list encounter
		PatientDashboardService dashboardService =  Context.getService(PatientDashboardService.class);
        String orderLocationId = "1";
        Location location = StringUtils.hasText(orderLocationId) ? Context.getLocationService().getLocation(Integer.parseInt(orderLocationId)) : null;
		LabService labService = Context.getService(LabService.class);
		List<Lab> labs = labService.getAllActivelab();

		Set<Concept> listParent = new HashSet<Concept>();
		if ( labs != null && !labs.isEmpty() ){
			for( Lab lab : labs ){
				 listParent.addAll(lab.getInvestigationsToDisplay());
			}
		}
		
        Patient patient = Context.getPatientService().getPatient(investigationCommand.getPatientId());
        
        String gpLabEncType = Context.getAdministrationService().getGlobalProperty(PatientDashboardConstants.PROPERTY_LAB_ENCOUTNER_TYPE);
        EncounterType labEncType = Context.getEncounterService().getEncounterType(gpLabEncType);
        
        if( "all".equalsIgnoreCase(investigationCommand.getDate())){
        	investigationCommand.setDate(null);
        }
        
		List<Encounter> encounters = dashboardService.getEncounter(patient, location, labEncType, investigationCommand.getDate());
		Set<String> dates = new TreeSet<String>(); // tree for dates
		if( encounters != null ){
			Set<Obs> listObs = null;
			//ghanshyam 07-may-2013 Bug #1429 Feedback [Patient Dashboard] Wrong Result Generated in Laboratory record(note:added below two line)
			Set<Node> nodes1 = new TreeSet<Node>(); // tree of node <conceptId, conceptName>
			Set<Node> nodes2 = new TreeSet<Node>(); // tree of node <conceptId, conceptName>
			Concept orderConcept = null;
			Concept obsConcept  = null;
			for( Encounter enc : encounters)
			{
				listObs = enc.getAllObs(false);
				if( listObs != null && !listObs.isEmpty() ){
					for( Obs obs : listObs ){
						// result 
						obsConcept = obs.getConcept();
						// loop the the end
						if(!checkSubmitTest(obsConcept.getConceptId(), investigationCommand.getTests())){
							continue;
						}
						// matched the concept
						orderConcept = obs.getOrder().getConcept();
						/*23/06 /2012 Kesavulu:Investigations of patients in OPD patient dashboard values are comeing now Bug #233, Bug #144, Bug #122 */
						String value = "";
						if( obs.getValueCoded() == null)
							value = obs.getValueText();
						else
							value = obs.getValueAsString(Context.getLocale());
						if( orderConcept.getConceptClass().getName().equalsIgnoreCase("Test")){
							//ghanshyam 07-may-2013 Bug #1429 Feedback [Patient Dashboard] Wrong Result Generated in Laboratory record(note:added fresh code in if condition)
							Node resultNode = new Node(obsConcept.getName().getName(), formatter.format(obs.getDateCreated()),
									value +"  " + getUnitStringFromConcept(obsConcept));
								
							Node childNode = new Node(obsConcept.getId(), obsConcept.getName().getName());
								
							nodes1 = addNodeAndChild(nodes1, orderConcept, childNode, resultNode, listParent, true);
						}else if( orderConcept.getConceptClass().getName().equalsIgnoreCase("Labset")){
							/*23/06 /2012 Kesavulu:Investigations of patients in OPD patient dashboard values are comeing now Bug #233, Bug #144, Bug #122 */
							//ghanshyam 07-may-2013 Bug #1429 Feedback [Patient Dashboard] Wrong Result Generated in Laboratory record(note:added date formatting)
							Node resultNode = new Node(obsConcept.getName().getName(), formatter.format(obs.getDateCreated()),
								value +"  " + getUnitStringFromConcept(obsConcept));
							
							Node childNode = new Node(obsConcept.getId(), obsConcept.getName().getName());
							
							nodes2 = addNodeAndChild(nodes2, orderConcept, childNode, resultNode, listParent, true);
						}
//						 add date
						dates.add(Context.getDateFormat().format(obs.getDateCreated())); // datecreatedOn in to dateTree
					}
				}
			}// end for encounter
				
			//ghanshyam 07-may-2013 Bug #1429 Feedback [Patient Dashboard] Wrong Result Generated in Laboratory record(note:added below two line)
			model.addAttribute("nodes1", nodes1);
			model.addAttribute("nodes2", nodes2);
		}
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "module/patientdashboard/investigationReportResult";
	}
	
	public boolean checkSubmitTest(Integer conceptId, Integer[] conIds){
		for( Integer id : conIds ){
			if( id.equals(conceptId) ){
				return true;
			}
		}
		return false;
	}
	
	private Node getNode(Integer id, Set<Node> nodes ){
		for( Node n : nodes ){
			if( n.getId().equals(id)){
				return n;
			}else {
				Node rs = getNode(id, n.getChildren());
				if( rs != null ) return rs;
			}
		}
		return null;
	}
	
	 public static String getUnitStringFromConcept(Concept con) {
	        String unit = null;
	        ConceptDatatype dt = con.getDatatype();
	        if (dt.isNumeric()) {
	            ConceptNumeric cn = Context.getConceptService().getConceptNumeric( con.getConceptId());
	            if(cn.getUnits()!=null)
	                unit = cn.getUnits();
	            else
	                unit = "";
	        } 
	        else
	        {
	            unit = "";
	        }
	        return unit;
	    }
	 
	 
	 
	 private Node  addNode(Node node, Set<Node>  nodes , Concept concept, Set<Concept> listParent) {
		
		 for( Concept pa : listParent ){
				for(  ConceptAnswer answer : pa.getAnswers()){
					if( answer.getAnswerConcept().getId().equals(concept.getConceptId())){
						Node parentNode =  getNode(pa.getConceptId(), nodes);
						if( parentNode == null ){
							parentNode = new Node(pa.getConceptId(), pa.getName().toString());
							nodes.add(parentNode);
						}
						// add orderNode to parent
							parentNode.addChild(node);
					}
				}
					
				//find parent of order concept : Labset  case
				List<Concept> set = Context.getConceptService().getConceptsByConceptSet(pa);
				if( set != null && set.size() > 0){
					if ( set.contains(concept)){
						Node parentNode =  getNode(pa.getConceptId(), nodes);
						if( parentNode == null ){
							parentNode = new Node(pa.getConceptId(), pa.getName().toString());
							nodes.add(parentNode);
						}
						// add orderNode to parent
						parentNode.addChild(node);
					}
				}
		}
		 return node;
	 }
	 
	 private Set<Node>  addNodeAndChild(Set<Node>  nodes , Concept pa, Node childNode, Node resultNode, Set<Concept> listParent, boolean result) {
		 Node paNode = getNode(pa.getConceptId(), nodes);
		 if( paNode == null ){
			Node node = new Node(pa.getConceptId(), pa.getName().toString());
			paNode =  addNode(node, nodes, pa, listParent);
		 }
		 if( ! result ){
			 paNode.getChildren().add(childNode);
		 }else {
			 paNode.addDates(resultNode.getDate());
			 paNode.getChildren().add(childNode);
			 paNode.addResultToMap(resultNode);
		 }
		 return nodes;
	 }
}
