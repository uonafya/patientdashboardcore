
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
// get context path in order to build controller url
	function getContextPath(){		
		pn = location.pathname;
		len = pn.indexOf("/", 1);				
		cp = pn.substring(0, len);
		return cp;
	}
</script>
<script type="text/javascript">
function datep(){
        var patientId = ${patientId};
		var date = jQuery("#drugIssuedDate").val();
jQuery.ajax({
				type : "POST",
				url : getContextPath() + "/module/patientdashboard/pharmacyRecord.htm",
				data : ({
					patientId			: patientId,
					date			    : date
				}),
				success : function(data) {
					jQuery("#pharmacyResultContainer").html(data);	
				}
});
}
</script>
<c:choose>
	<c:when test="${ not empty dates }">
		<form id="pharmacyRecordForm">
			<table width="100%">
				<tr valign="top">
					<td id="pharmacyResultContainer" style="text-align: left;"></td>
					<td id="pharmacyFormContainer" style="text-align: right;">
						Date: <select name="drugIssuedDate" id="drugIssuedDate"
						onchange="datep();">
							<option selected="selected" value="null">Select</option>
							<option value="all">All</option>
							<c:forEach var="date" items="${dates}">
								<option value="${date}">${date}</option>
							</c:forEach>
					</select>
					</td>
			</table>
		</form>
	</c:when>
	<c:otherwise>No Pharmacy record found</c:otherwise>
</c:choose>