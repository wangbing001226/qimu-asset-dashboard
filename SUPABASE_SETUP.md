# 跨设备同步设置

看板通过 Supabase Auth 登录，并将浏览器加密后的单条资产状态保存到 Supabase。Supabase 只收到密文、随机盐和版本号；同步密码不会上传。忘记同步密码后，云端密文无法解开。

## 建立项目

1. 在 Supabase 创建项目并确认邮箱密码登录已启用。
2. 在 SQL Editor 运行本仓库的 `supabase-setup.sql`。
3. 从 Project Settings → API 获取 Project URL 与 publishable key（旧项目可用 anon key）。不要使用 `service_role` key。
4. 在 GitHub Pages 页面底部“跨设备同步”中填写 Project URL、publishable/anon key，点击“保存项目配置”。
5. 用邮箱创建账号，按邮件完成验证后登录。首次设备输入同步密码，将当前浏览器看板数据加密上传。
6. 在手机打开同一看板、填写同一项目配置并登录同一账号，再输入同一个同步密码，即可恢复云端数据。之后本地修改会自动同步。

账号密码用于 Supabase 登录；同步密码单独用于客户端 AES-GCM 加密。两者都不要交给他人。请妥善保存同步密码并继续定期导出 JSON 备份。

## 冲突处理

数据以版本号做条件更新，避免静默覆盖并发编辑。检测到云端和本地都有较新版本时，请明确选择“以云端覆盖本机”或“以本机覆盖云端”。
