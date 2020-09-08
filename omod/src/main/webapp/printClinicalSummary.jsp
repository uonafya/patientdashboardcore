<%--
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
--%>
<%@ include file="/WEB-INF/template/include.jsp"%>

<script type="text/javascript">
	jQuery(document).ready(function () {
		var otherInstructions = '${otherInstructions}';
		if (otherInstructions != "") {

		}
		else {
			jQuery("#othInstt").hide();
		}

		var internalReferral = '${internal}';
		if (internalReferral != "") {

		}
		else {
			jQuery("#intReff").hide();
		}

		var externalReferral = '${external}';
		if (externalReferral != "") {

		}
		else {
			jQuery("#extReff").hide();
		}


		var dateFollowUp = '${followUpDate}';
		if (dateFollowUp != "") {

		}
		else {
			jQuery("#followupdate").hide();
		}

		var ipdward = '${ipdAdmissionWard}';
		if (ipdward != "") {

		}
		else {
			jQuery("#ipdadmissionward").hide();
		}

	});
</script>

<table class="box">
	<tr>
		<center>
			<b>
				<font size="4">${hospitalName}</font>
			</b>
		</center>
	</tr>
	<tr>
		<td><strong>Date & Time of the Visit:</strong></td>
		<td>${currentDateTime}</td>
		<td><strong>Patient Category:</strong></td>
		<td>${selectedCategory}</td>
	</tr>
	<tr>
		<td><strong>Patient ID:</strong></td>
		<td>${patient.patientIdentifier.identifier}</td>
		<td><strong>Name:</strong></td>
		<td>${patientName}</td>
	</tr>
	<tr>
		<td><strong>Gender:</strong></td>
		<td>
			<c:choose>
				<c:when test="${patient.gender eq 'M'}">
					Male
				</c:when>
				<c:otherwise>
					Female
				</c:otherwise>
			</c:choose>
		</td>
		<td><strong>Age:</strong></td>
		<td>${age}</td>
	</tr>
	<tr>
		<td><strong>OPD Consulted:</strong></td>
		<td>${opdConceptName}</td>
		<td><strong>Encounter No:</strong></td>
		<td>${encounterId}</td>
	</tr>
</table>


<table class="box">
	<br />
	<tr>
		<center>
			<b>
				<font size="2">CLINICAL SUMMARY</font>
			</b>
		</center>
	</tr>
	<tr>
		<td><strong>History of Present Illness:</strong></td>
		<td>${illnessHistory}</td>
	</tr>
	<c:choose>
		<c:when test="${not empty pdiagnosiss}">
			<tr>
				<td><strong>Provisional Diagnosis:</strong></td>
				<c:forEach items="${pdiagnosiss}" var="pdiagnosis">
					</td>
					<td>${pdiagnosis.name}</td>
			</tr>
			<tr>
				<td>
					</c:forEach>
			</tr>
		</c:when>
		<c:otherwise>
			<tr>
				<td><strong>Final Diagnosis:</strong></td>
				<c:forEach items="${fdiagnosiss}" var="fdiagnosis">
					</td>
					<td>${fdiagnosis.name}</td>
			</tr>
			<tr>
				<td>
					</c:forEach>
			</tr>
		</c:otherwise>
	</c:choose>

	<tr>
		<td><strong>Procedure:</strong></td>
		<c:forEach items="${procedures}" var="procedure">
			</td>
			<td>${procedure.name}</td>
	</tr>
	<tr>
		<td>
			</c:forEach>
	</tr>

	<tr>
		<td><strong>Investigation Advised :</strong></td>
		<c:forEach items="${investigations}" var="investigation" varStatus="index">
			</td>
			<td>${index.count}.${investigation.name}</td>
	</tr>
	<tr>
		<td>
			</c:forEach>
	</tr>
</table>

<table class="box">
	<br />
	<tr>
		<center>
			<b>
				<font size="2">TREATMENT ADVISED</font>
			</b>
		</center>
	</tr>
	<tr align="center">
		<th><strong>S.No</strong></th>
		<th><strong>Drug</strong></th>
		<th><strong>Formulation</strong></th>
		<th><strong>Frequency</strong></th>
		<th><strong>No of Days</strong></th>
		<th><strong>Comments</strong></th>
	</tr>
	<c:forEach items="${opdDrugOrders}" var="opdDrugOrder" varStatus="index">
		<tr align="center">
			<td>${index.count}</td>
			<td>${opdDrugOrder.inventoryDrug.name}</td>
			<td>${opdDrugOrder.inventoryDrugFormulation.name}-${opdDrugOrder.inventoryDrugFormulation.dozage}</td>
			<td>${opdDrugOrder.frequency.name}</td>
			<td>${opdDrugOrder.noOfDays}</td>
			<td>${opdDrugOrder.comments}</td>
		</tr>
	</c:forEach>
</table>

<table class="box">
	<tr id="othInstt">
		<td><strong>Other Instructions:</strong></td>
		<td>${otherInstructions}</td>
	</tr>
	<tr id="intReff">
		<td><strong>Internal Referral:</strong></td>
		<td>${internal}</td>
	</tr>
	<tr id="extReff">
		<td><strong>External Referral:</strong></td>
		<td>${external}</td>
	</tr>
	<tr>
		<td><strong>OPD Visit Outcome:</strong></td>
		<td>${visitOutCome} -</td>
		<td id="followupdate">${followUpDate}</td>
		<td id="ipdadmissionward">${ipdAdmissionWard}</td>
	</tr>
</table>
<table>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<tr>
		<p style="text-align: right;">${treatingDoctor}</p>
	</tr>
	<br />
	<br />
	<br />
	<tr>
		<center>
			<b>
				<font size="2">Please Note - All follow-up appointments
					are scheduled between 3:00 -4:00 pm everyday</font>
			</b>
			<br>
			<p style="font-weight: bold;">${slipMessage}</p>
		</center>
	</tr>
</table>