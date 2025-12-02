from datetime import datetime
import json

def load(path):
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)

def extract_items(data):
    root = data[0]
    rows = root.get("Rows", {})

    result = {}

    for row_name, row_data in rows.items():

        allowstack_key = next(
            (k for k in row_data if k.startswith("AllowStacking")),
            None
        )

        maxstack_key = next(
            (k for k in row_data if k.startswith("MaxStack")),
            None
        )

        if maxstack_key and allowstack_key:
            result[row_name] = {
                "StackSize": row_data.get(maxstack_key),
                "AllowStack": row_data.get(allowstack_key)
            }

    return result

def build_lua(stack_data):
    lines = []
    lines.append(f"-- Generated at {datetime.now().strftime("%Y-%m-%d %H:%M")}")
    lines.append("local stackTweaks = {}")
    lines.append("")

    for item, values in stack_data.items():
        lines.append(f"stackTweaks[\"{item}\"] = {{")
        lines.append(f"    stackSize = {values['StackSize']},")
        allow = "true" if values["AllowStack"] else "false"
        lines.append(f"    allowStack = {allow}")
        lines.append("}")
        lines.append("")

    lines.append("return stackTweaks")
    return "\n".join(lines)

def main():
    data = load("MasterItemList.json")
    items = extract_items(data)

    lua_output = build_lua(items)

    with open("stackTweaks.lua", "w", encoding="utf-8") as f:
        f.write(lua_output)

    print("Generated stackTweaks.lua")

if __name__ == "__main__":
    main()
