<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<c:set var="code" value="${currentNode.properties.code.string}"/>
<c:if test="${! empty code}">
    <c:set var="style" value="${currentNode.properties.style.string}"/>
    <c:if test="${empty style}">
        <c:set var="style" value="default"/>
    </c:if>
    <template:addResources type="css" resources="${style}.css"/>
    <template:addResources type="javascript" resources="highlight.pack.js"/>

    <c:set var="showcopybutton" value="${currentNode.properties.showcopybutton.boolean}"/>
    <c:set var="showlinenumber" value="${currentNode.properties.showlinenumber.boolean}"/>

    <c:if test="${showlinenumber}">
        <template:addResources type="css" resources="highlightjs-line-numbers.css"/>
        <template:addResources type="javascript" resources="highlightjs-line-numbers.min.js"/>
    </c:if>
    <c:if test="${showcopybutton}">
        <template:addResources type="javascript" resources="clipboard.min.js"/>
        <template:addResources type="css" resources="clipboard.css"/>
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
                    <c:if test="${showcopybutton}">
                        var copybutton = '<div class="bd-clipboard"><span class="btn-clipboard" title="<fmt:message key='jnt_highlightjs.copyToClipboard'/>"><fmt:message key="jnt_highlightjs.copy"/></span></div>';
                        $(this).before(copybutton);
                    </c:if>
                });
                var clipboard = new Clipboard('.btn-clipboard', {
                    target: function (trigger) {
                        return trigger.parentNode.nextElementSibling
                    }
                })

                <%--clipboard.on('success', function (e) {
                    $(e.trigger)
                            .attr('title', 'Copied!')
                            .tooltip('_fixTitle')
                            .tooltip('show')
                            .attr('title', 'Copy to clipboard')
                            .tooltip('_fixTitle')

                    e.clearSelection()
                })

                clipboard.on('error', function (e) {
                    var fallbackMsg = /Mac/i.test(navigator.userAgent) ? 'Press \u2318 to copy' : 'Press Ctrl-C to copy'

                    $(e.trigger)
                            .attr('title', fallbackMsg)
                            .tooltip('_fixTitle')
                            .tooltip('show')
                            .attr('title', 'Copy to clipboard')
                            .tooltip('_fixTitle')--%>

                <c:if test="${showlinenumber}">
                    $('code.hljs').each(function(i, block) {
                        hljs.lineNumbersBlock(block);
                    });
                </c:if>
            });
        </script>
    </template:addResources>
</c:if>
