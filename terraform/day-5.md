# Day-5
# Terraform variables
    1️⃣ **String**  
    2️⃣ **Number**  
    3️⃣ **Bool (Boolean)**  
    4️⃣ **List**  
    5️⃣ **Map**  
    6️⃣ **Object**  
    7️⃣ **Tuple**  
    8️⃣ **Any**

---

### **1️⃣ String**
   - **Concept:**  
     A string variable holds text values. It is the most common variable type used in Terraform.
   - **Example:**  
     Define a variable to store an instance type or region name:
   ```hcl
   variable "region" {
     type    = string
     default = "us-west-2"
   }
   ```
   - **Usage:**  
     The `string` type is used to hold text values, such as names, identifiers, or any alphanumeric data.

---

### **2️⃣ Number**
   - **Concept:**  
     A number variable holds numeric values (both integer and floating point).
   - **Example:**  
     Define a variable for the instance size in terms of CPU count or instance count:
   ```hcl
   variable "instance_count" {
     type    = number
     default = 3
   }
   ```
   - **Usage:**  
     The `number` type can store both integer and decimal values, like the number of instances or resource size.

---

### **3️⃣ Bool (Boolean)**
   - **Concept:**  
     A boolean variable holds `true` or `false` values.
   - **Example:**  
     Define a variable to control whether a feature should be enabled or not:
   ```hcl
   variable "enable_monitoring" {
     type    = bool
     default = true
   }
   ```
   - **Usage:**  
     The `bool` type is ideal for flags or toggle-type variables that accept `true` or `false`.

---

### **4️⃣ List**
   - **Concept:**  
     A list variable holds a sequence of values. All values in the list should be of the same type.
   - **Example:**  
     Define a variable to hold a list of instance types:
   ```hcl
   variable "instance_types" {
     type    = list(string)
     default = ["t2.micro", "t2.small", "t2.medium"]
   }
   ```
   - **Usage:**  
     The `list` type is used when you need an ordered collection of elements, such as a list of instance types or availability zones.

---

### **5️⃣ Map**
   - **Concept:**  
     A map variable holds key-value pairs. The keys must be unique and are typically strings, while the values can be of any type.
   - **Example:**  
     Define a variable to hold a map of regions and their corresponding AMI IDs:
   ```hcl
   variable "ami_ids" {
     type = map(string)
     default = {
       "us-west-1" = "ami-12345678"
       "us-west-2" = "ami-87654321"
     }
   }
   ```
   - **Usage:**  
     The `map` type is useful for storing key-value pairs, such as region to AMI mappings or any other associative data.

---

### **6️⃣ Object**
   - **Concept:**  
     An object variable holds a structured set of named attributes with different data types. Each attribute in the object can have its own type.
   - **Example:**  
     Define a variable to hold an object representing a server:
   ```hcl
   variable "server" {
     type = object({
       name   = string
       cpu    = number
       memory = string
     })
     default = {
       name   = "web-server"
       cpu    = 2
       memory = "8GB"
     }
   }
   ```
   - **Usage:**  
     The `object` type is useful for defining complex data structures with multiple properties, such as server configurations, API credentials, or any multi-attribute resource.

---

### **7️⃣ Tuple**
   - **Concept:**  
     A tuple is an ordered collection of elements where each element can have a different type. Unlike a list, the types can differ between elements.
   - **Example:**  
     Define a variable for a tuple containing a string, a number, and a boolean:
   ```hcl
   variable "server_config" {
     type    = tuple([string, number, bool])
     default = ["web-server", 2, true]
   }
   ```
   - **Usage:**  
     The `tuple` type is used when you need an ordered collection with different data types, such as a mix of strings, numbers, and booleans.

---

### **8️⃣ Any**
   - **Concept:**  
     The `any` type allows any type of value to be used. It is flexible and can accept any value, whether it is a string, number, list, map, etc.
   - **Example:**  
     Define a variable for a flexible value:
   ```hcl
   variable "generic_value" {
     type    = any
     default = "hello"
   }
   ```
   - **Usage:**  
     The `any` type is useful when you don’t know the exact type of data that will be passed or when you want to accept multiple data types in the same variable.

---

### **Summary of Terraform Variable Types**
1. **String:** Textual data (e.g., region names, instance IDs).
2. **Number:** Numeric values (e.g., instance count, resource sizes).
3. **Bool (Boolean):** True or false values (e.g., enable features).
4. **List:** Ordered collection of elements (e.g., list of instance types).
5. **Map:** Key-value pairs (e.g., region to AMI mappings).
6. **Object:** Structured data with named attributes (e.g., server configurations).
7. **Tuple:** Ordered collection with elements of different types (e.g., string, number, and boolean).
8. **Any:** Flexible data type that can hold any value.

---

Each variable type serves a unique purpose, and you can choose the appropriate one based on the structure and type of data you are working with. Let me know if you need further clarification!