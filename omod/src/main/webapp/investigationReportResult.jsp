 <%--
 *  * The contents of this file are subject to the OpenMRS Public License
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
--%> 
<%@ include file="/WEB-INF/template/include.jsp" %>
<style>
.rsTable{ margin:5px 5px;text-align:center; border-style:1px  solid black; border-collapse: collapse;}
.rsCell { padding:3px 3px;}
</style>
<c:choose>
<%-- ghanshyam 07-may-2013 Bug #1429 Feedback [Patient Dashboard] Wrong Result Generated in Laboratory record(note:added nodes1 and nodes2 condition)--%>
	<c:when test="${not empty nodes1 or not empty nodes2}">
		<c:forEach items="${nodes1 }" var="node">
			<table class="rsTable" cellspacing="3" border="1"  cellpadding="3">
				<tr>
					<td bgcolor="#3BB9FF"><span style="display:block"><b>${node.name }</b></span></td>
				</tr>
				<tr>
					<td>
						<c:forEach items="${node.children }" var="child">
							<table class="rsTable" cellspacing="3" cellpadding="3" border="1" >
								<tr>
									<td><span style="display:block"><b>${child.name }</b></span></td>
								</tr>
								
								<c:if test="${not empty child.children}"> 
									<td>
										<table class="rsTable"  cellspacing="3" cellpadding="3" border="1" >
											<tr>
												<th></th>
												<c:forEach items="${child.children}" var="leaf">
													<th><span style="display:block"><b>${leaf.name} </b></th>
												</c:forEach>
											</tr>		
												<c:forEach items="${child.dates}" var="date">
													<tr>
														<td>${date}</td>
														<c:forEach items="${child.mapResult[date]}" var="test">
															<td class="rsCell">${test.result}</td>
														</c:forEach>
													</tr>
												</c:forEach>
										</table>
									</td>
								</c:if>
							</table>
						</c:forEach>
					</td>
				</tr>
			</table>
		</c:forEach>
		
		
		<c:forEach items="${nodes2 }" var="node">
			<table class="rsTable" cellspacing="3" border="1"  cellpadding="3">
				<tr>
					<td bgcolor="#3BB9FF"><span style="display:block"><b>${node.name }</b></span></td>
				</tr>
				<tr>
					<td>
						<c:forEach items="${node.children }" var="child">
							<table class="rsTable" cellspacing="3" cellpadding="3" border="1" >
								<tr>
									<td><span style="display:block"><b>${child.name }</b></span></td>
								</tr>
								
								<c:if test="${not empty child.children}"> 
									<td>
										<table class="rsTable"  cellspacing="3" cellpadding="3" border="1" >
											<tr>
												<th></th>
												<c:forEach items="${child.children}" var="leaf">
													<th><span style="display:block"><b>${leaf.name} </b></th>
												</c:forEach>
											</tr>		
												<c:forEach items="${child.dates}" var="date">
													<tr>
														<td>${date}</td>
														<c:forEach items="${child.mapResult[date]}" var="test">
															<td class="rsCell">${test.result}</td>
														</c:forEach>
													</tr>
												</c:forEach>
										</table>
									</td>
								</c:if>
							</table>
						</c:forEach>
					</td>
				</tr>
			</table>
		</c:forEach>
		
	</c:when>
<%-- ghanshyam 09-may-2013 Support #1496 [Patient Dashboard]UI Change in Laboratory Record in Patient Dashboard --%>
	<c:otherwise>
	PLEASE SELECT THE TESTS.
	</c:otherwise>
</c:choose>