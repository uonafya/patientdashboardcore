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
<%@ include file="/WEB-INF/template/include.jsp" %>
<script type="text/javascript">
//  reenter result for a test
	function reEnterResult(testId){
		tb_show("testing", "showRadiologyForm.form?modal=true&height=600&width=800&mode=edit&radiologyTestId=" + testId);	
	}
	
	// show form for xray test
	function reEnterXRayResult(testId){
		tb_show("testing", "getDefaultXRayFormm.form?modal=true&height=600&width=800&mode=edit&radiologyTestId=" + testId);	
	}
</script>
<table width="100%" class="rsTable">
		<tr align="center"> 
			<th>Sr.No.</th>
			<th>Results</th>
			<th>Date</th>
			<th>SubTest</th>
		</tr>
		<c:forEach var="test" items="${radiologytests}" varStatus="varStatus">
	    <tr align="center" class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } '>
		<td><c:out value="${varStatus.count }"/></td>
		<td>
		<c:choose>
						<c:when test='${test.xray}'>							
							<a href="javascript:reEnterXRayResult(${test.testId});">
								View results
							</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:reEnterResult(${test.testId});">
								View results
							</a>
						</c:otherwise>
					</c:choose>
		 </td>
		<td>${test.startDate}</td>
		<td>${test.testName}</td>
		</tr>
		</c:forEach>
</table>