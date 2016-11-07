<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<c:set var="code" value="${currentNode.properties.code.string}"/>
<c:if test="${! empty code}">
    <c:set var="style" value="${currentNode.properties.style.string}"/>
    <c:if test="${empty style}">
        <c:set var="style" value="default"/>
    </c:if>
    <template:addResources type="css" resources="${style}.css"/>
    <template:addResources type="javascript" resources="highlight.pack.js"/>
    <c:if test="${currentNode.properties.showlinenumber.boolean}">
        <template:addResources type="css" resources="highlightjs-line-numbers.css"/>
        <template:addResources type="javascript" resources="highlightjs-line-numbers.min.js"/>
    </c:if>
    <c:set var="language" value="${currentNode.properties.language.string}"/>
    <c:if test="${! empty language && language ne 'auto'}">
        <c:set var="languageCss" value="${' '}class=\"${language}\""/>
    </c:if>
    <pre><code${languageCss}>${fn:escapeXml(code)}</code></pre>
    <template:addResources type="inline">
        <script>
            $(document).ready(function () {
                $('pre code').each(function (i, block) {
                    hljs.highlightBlock(block);
                });
                <c:if test="${currentNode.properties.showlinenumber.boolean}">
                    $('code.hljs').each(function(i, block) {
                        hljs.lineNumbersBlock(block);
                    });
                </c:if>
            });
        </script>
    </template:addResources>
</c:if>
