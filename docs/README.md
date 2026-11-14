# Tài liệu Travel_V1

| File | Mô tả |
|---|---|
| [khao-sat-du-an.md](./khao-sat-du-an.md) | Báo cáo khảo sát FE + BE (cập nhật 2026-11-14) |
| [project_context.md](./project_context.md) | Dự án là gì, cấu trúc monorepo |
| [runtime_environment.md](./runtime_environment.md) | Cách chạy infra, backend, Flutter |

## Tài liệu ngoài `docs/`

| Vị trí | Mô tả |
|---|---|
| [`frontend/brain/brain.md`](../frontend/brain/brain.md) | Bản đồ trạng thái & kiến trúc Flutter |
| [`backend/README.md`](../backend/README.md) | Chi tiết backend NestJS |
| [`backend/contracts/openapi.json`](../backend/contracts/openapi.json) | Hợp đồng API (nguồn tin cậy) |
| [`frontend/docs/design/screen/`](../frontend/docs/design/screen/) | Design Stitch theo màn hình |

## Doc theo màn hình (Stitch → code)

Khi làm màn mới từ Stitch, tạo thư mục `docs/screens/<screen_name>/` với:

- `stitch/` — reference ảnh + `screen.html`
- `screen_analysis.md`, `backend_mapping.md`, `conflicts.md`, `screen_contract.md`
- `implementation.md`, `implementation_report.md`, `runtime_test_report.md`
