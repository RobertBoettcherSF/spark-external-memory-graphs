pragma SPARK_Mode (On);

package External_Memory_Graphs is

   -- Represents the block size B from the External Memory Model
   Max_Edges_Per_Block : constant := 4096;

   type Vertex_Id is new Natural range 1 .. 1_000_000;
   type Edge_Weight is new Integer range 0 .. 1_000_000;

   -- Represents an undirected graph edge for the Minimum Spanning Tree algorithm
   type Edge is record
      U      : Vertex_Id;
      V      : Vertex_Id;
      Weight : Edge_Weight;
   end record;

   type Edge_Block_Array is array (1 .. Max_Edges_Per_Block) of Edge;

   -- Represents a block of data transferred from secondary to main memory
   type IO_Block is record
      Edges : Edge_Block_Array;
      Count : Natural range 0 .. Max_Edges_Per_Block;
   end record;

   -- Clears the block for a new read/write pass
   procedure Initialize_Block (Block : out IO_Block)
     with Post => Block.Count = 0;

   -- Safely appends an edge to the I/O block, returning Success status
   procedure Append_Edge (Block    : in out IO_Block;
                          New_Edge : in Edge;
                          Success  : out Boolean)
     with 
       Post => (if Success then Block.Count = Block.Count'Old + 1
                else Block.Count = Block.Count'Old);

end External_Memory_Graphs;
