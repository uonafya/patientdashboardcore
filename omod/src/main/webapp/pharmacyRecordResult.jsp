
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:choose>
	<c:when test="${ not empty drugDetails }">
		<span class="boxHeader">Issue drugs detail</span>
		<div class="box">
			<table width="100%" class="rsTable">
				<tr align="center">
					<th>#</th>
					<th>Category</th>
					<th>Drug</th>
					<th>Formulation</th>
					<th>Issue date</th>
					<th>Quantity</th>
				</tr>
				<c:forEach items="${drugDetails}" var="detail" varStatus="varStatus">
					<tr align="center"
						class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } '>
						<td><c:out value="${varStatus.count }" /></td>
						<td>${detail.transactionDetail.drug.category.name}</td>
						<td>${detail.transactionDetail.drug.name}</td>
						<td>${detail.transactionDetail.formulation.name}-${detail.transactionDetail.formulation.dozage}</td>
						 <%--
						<td><openmrs:formatDate date="${detail.transactionDetail.createdOn}" type="textbox" /></td>
						--%>
						<%-- ghanshyam,date:25-april-2013 Feedback #1391 Add Pharmacy record of patient in Dashboard --%>
						<td><fmt:formatDate type="both" value="${detail.transactionDetail.createdOn}" /></td>
						<td>${detail.quantity }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>