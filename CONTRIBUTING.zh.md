# 贡献指南
-   [贡献者许可协议](#贡献者许可协议.md)
-   [入门](#入门.md)
-   [开发指导](#开发指导.md)
    -   [代码风格](#代码风格.md)
    -   [门禁异常处理](#门禁异常处理.md)
    -   [Fork-Pull开发模式](#Fork-Pull开发模式.md)
    -   [报告问题](#报告问题.md)
    -   [提出PR](#提出PR.md)
<h2 id="贡献者许可协议.md">贡献者许可协议</h2>

在您第一次向 社区提交代码之前，需要签署 CLA。

对于个人贡献者，详细信息请参考[链接](https://clasign.osinfra.cn/sign/Z2l0ZWUlMkZhc2NlbmQ=)

<h2 id="入门.md">入门</h2>

-   在[Gitee](https://gitee.com/ascend/ascend-docker-image)上Fork存储库。
-   行为准则 [coc](https://gitee.com/ascend/community/blob/master/code-of-conduct_zh_cn.md)。

<h2 id="开发指导.md">开发指导</h2>

-   **[代码风格](#代码风格.md)**  

-   **[门禁异常处理](#门禁异常处理.md)**  

-   **[Fork-Pull开发模式](#Fork-Pull开发模式.md)**  

-   **[报告问题](#报告问题.md)**  

-   **[提出PR](#提出PR.md)**  


<h2 id="代码风格.md">代码风格</h2>

请遵循这些风格，以使 易于开发、审查和维护。

-   编码指南

    请在社区使用规统一的编码分格，python建议的编码风格是[PEP 8编码样式](https://pep8.org/)，C++编码所建议的风格是  [Google C++编码指南](http://google.github.io/styleguide/cppguide.html)  。可以使用[CppLint](https://github.com/cpplint/cpplint)，[CppCheck](http://cppcheck.sourceforge.net/)，[CMakeLint](https://github.com/cmake-lint/cmake-lint)，[CodeSpell](https://github.com/codespell-project/codespell)，  [Lizard](http://www.lizard.ws/)，[ShellCheck](https://github.com/koalaman/shellcheck)和[pylint](https://pylint.org/)检查代码的格式，建议在您的IDE中安装这些插件。

-   单元测试指南

    请在社区使用统一的单元测试风格，  Python中建议的单元测试风格是[pytest](http://www.pytest.org/en/latest/)，C++单元测试所建议的风格是  [Googletest Primer](#https://github.com/google/googletest/blob/master/docs/primer.md)  。测试用例的设计意图应该通过它的注释名称来反映。

-   重构指南

    我们鼓励开发人员重构我们的代码以消除[代码异味](https://en.wikipedia.org/wiki/Code_smell)。所有的代码都应该符合编码风格和测试风格的需求，重构代码也不例外。当您收到警告时，您必须重构要合并的代码。


<h2 id="门禁异常处理.md">门禁异常处理</h2>

门禁异常主要包含如下几种，请根据相关提示解决异常问题。

-   编译异常

    请检查代码编译失败的原因，解决问题后重新编译即可。

-   静态检查异常（代码Bug、代码漏洞、代码异味）

    请依照提示查找代码中的异常并解决。

-   UT测试未通过

    请根据提示，查找测试用例不通过项并检查原因，解决后再测试。


<h2 id="Fork-Pull开发模式.md">Fork-Pull开发模式</h2>

1.  Fork ascend-docker-image存储库。

    在向ascend-docker-image代码仓提交代码之前，请确保该项目已经Fork到您自己的存储库。这意味着ascend-docker-image存储库和您自己的存储库之间将存在并行开发，因此请注意避免存储库之间的不一致。

2.  克隆远程仓库。

    如果要将代码下载到本地环境，git是很好的方法：

    ```
    # For Gitee
    git clone https://gitee.com/ascend/ascend-docker-image.git
    git remote add upstream https://gitee.com/ascend/ascend-docker-image.git
    ```

3.  本地开发代码。

    为了避免多个分支之间的不一致，建议创建新的分支进行开发：

    ```
    git checkout -b {new_branch_name} origin/master
    ```

    以master分支为例，ascend-docker-image可能会根据需要创建版本分支和下游开发分支，请先修复上游的bug。然后就可以随意更改代码了。

4.  将代码推送到远程仓库。

    更新代码后，您需要以正式的方式推送更新：

    ```
    git add .
    git status # Check the update status
    git commit -m "Your commit title"
    git commit -s --amend #Add the concrete description of your commit
    git push origin {new_branch_name}
    ```

5.  向 ascend-docker-image存储库拉取请求。

    在最后一步中，您需要在新分支和“ascend-docker-image master“分支之间拉取比较请求。完成拉取请求后，“Jenkins CI“将自动设置为构建测试。您的pull request应该尽快合并到上游 master 分支，以降低合并的风险。


<h2 id="报告问题.md">报告问题</h2>

为项目做出贡献的一个好方法是在遇到问题时发送详细报告。我们总是很感激写得很好、彻底的错误报告，并会由此感谢您！

报告问题时，请参考以下格式：

-   这是错误报告还是功能请求？
-   什么样的问题，添加标签以在问题仪表板上突出显示。
-   发生了什么？
-   您预计会发生什么？
-   如何重现它？（尽可能最小和精确。）
-   给审稿人的特别说明？

问题咨询：

-   如果您发现一个未解决的问题，而这正是您要解决的问题，请对该问题发表一些评论，告诉其他人您将负责它。
-   如果问题已打开一段时间，建议贡献者在解决该问题之前进行预检查。
-   如果您解决了自己报告的问题，则还需要在关闭该问题之前让其他人知道。

<h2 id="提出PR.md">提出PR</h2>

-   在[Gitee](https://gitee.com/ascend/ascend-docker-image/issues)上提出您的想法作为_问题_。
-   如果是需要大量设计细节的新功能，还应提交设计方案。
-   在问题讨论和设计提案审查中达成共识后，完成分叉回购的开发并提交 PR（Pull Request）。
-   在从批准者那里收到2+ LGTM（Looks Good To Me）之前，不允许任何PR 。请注意，审批人不允许在自己的 PR 上添加LGTM。
-   在 PR 被充分讨论后，它将根据讨论的结果被合并、放弃或拒绝。

公关咨询：

-   应避免任何不相关的更改。
-   确保你的提交历史被排序。
-   始终将您的分支与主分支保持一致。
-   对于错误修复 PR，请确保链接所有相关问题。
